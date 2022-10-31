import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:househunt/models/asset_models.dart';

class FireBaseController {
  static Future uploadFiles(int id, RxList<FileAsset> files,
      {bool merge = false}) async {
    final assets = [];
    final List<Map<String, dynamic>> references = [];

    for (final asset in files) {
      String imgPath = asset.file.path.split("/").last;
      Reference db = FirebaseStorage.instance.ref("Housing/$id/$imgPath");

      references.add(
        {'db': db, 'file': File(asset.file.path)},
      );
    }

    // promise.allSettled

    await Future.wait([
      ...references.map(
        (e) => e['db']!.putFile(
          e['file']!,
        ),
      ),
    ]);

    for (var i = 0; i < references.length; i++) {
      String imgPath = files[i].file.path.split("/").last;
      assets.add({
        'Url': await references[i]['db'].getDownloadURL(),
        'name': imgPath,
        'type': files[i].type == AssetType.photo ? 'photo' : 'video'
      });
    }

    await FirebaseFirestore.instance.collection('housing').doc('$id').set({
      'assets': assets,
    });
  }

  static Future<String> uploadFileProfile(int id, String path) async {
    File img = File(path);
    // String imgPath = img.path.split("/").last;
    Reference db = FirebaseStorage.instance.ref("Users/$id");
    await db.putFile(img);
    String url = await db.getDownloadURL();
    FirebaseFirestore.instance.collection('users').doc('$id').set({'Url': url});
    return url;
  }

  static Widget display(int id) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('housing')
            .doc('$id')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();

          // print(snapshot.data.);
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  SizedBox(
                // make it expand to fit the parent
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                  ),
                ),
              ),
              imageUrl: '${snapshot.data!['assets'][0]['Url']}',
              fit: BoxFit.fill,
            ),
          );
        });
  }

  static Future deleteHousing(int id) async {
    Reference ref = FirebaseStorage.instance.ref("Housing/$id");

    await Future.wait([
      FirebaseFirestore.instance.collection('housing').doc('$id').delete(),
      // delete photos from storage
      ref.listAll().then((dir) {
        for (var fileRef in dir.items) {
          fileRef.delete();
        }
      })
    ]);
  }

  static Future deleteAssets(List<Map> list, int id) async {
    for (var item in list) {
      final storageRef =
          FirebaseStorage.instance.ref("Housing/$id/${item['name']}");
      await storageRef.delete();
      await FirebaseFirestore.instance
          .collection('housing')
          .doc('$id')
          .delete();
    }
  }

  static Future updateAssets(
    List existingItems,
    List<FileAsset> files,
    int id,
    List deletedItems,
  ) async {
    final assets = existingItems
        .map((e) => {
              'Url': e['Url'],
              'name': e['name'],
              'type': e['type'],
            })
        .toList();

    final List<Map<String, dynamic>> references = [];

    for (final asset in files) {
      String imgPath = asset.file.path.split("/").last;
      Reference db = FirebaseStorage.instance.ref("Housing/$id/$imgPath");

      references.add(
        {'db': db, 'file': File(asset.file.path)},
      );
    }

    await Future.wait([
      ...references.map(
        (e) => e['db']!.putFile(
          e['file'],
        ),
      ),
      // delete photos from storage
      ...deletedItems.map((e) {
        final storageRef =
            FirebaseStorage.instance.ref("Housing/$id/${e['name']}");
        return storageRef.delete();
      })
    ]);

    for (var i = 0; i < references.length; i++) {
      String imgPath = files[i].file.path.split("/").last;
      assets.add({
        'Url': await references[i]['db'].getDownloadURL(),
        'name': imgPath,
        'type': files[i].type == AssetType.photo ? 'photo' : 'video'
      });
    }

    await FirebaseFirestore.instance.collection('housing').doc('$id').set(
      {
        'assets': assets,
      },
    );
  }

  static Future<List<Map<String, dynamic>>> getAssets(int id) async {
    final ref = FirebaseFirestore.instance.collection('housing').doc('$id');

    final List<Map<String, dynamic>> docs = [];

    try {
      await ref.get().then((value) {
        docs.addAll([...(value.data()!['assets'])]);
      });

      return docs;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String?> getUserImageUrl(int id) async {
    final docRef = FirebaseFirestore.instance.collection('users').doc('$id');
    final value = await docRef.get();

    if (value.exists) {
      return value.data()!['Url'];
    }
    return null;
  }

  static Widget displayList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('housing').snapshots(),
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                Container(
                  width: Get.width / 2,
                  height: Get.width / 2.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        snapshot.data?.docs[0]['photo'][0],
                      ),
                    ),
                  ),
                ),
                // IconButton(
                //     onPressed: () async {
                //       if (snapshot.data?.docs.length == 1) {
                //         Get.snackbar("Error", "Atleast one image is required");
                //       } else {
                //         FirebaseStorage.instance
                //             .ref(
                //                 "Housing/$id23/${snapshot.data?.docs[index]['name']}")
                //             .delete();
                //         snapshot.data?.docs[index].reference.delete();
                //       }
                //     },
                //     icon: const Icon(Icons.cancel))
              ],
            );
          },
        );
      },
    );
  }
}
