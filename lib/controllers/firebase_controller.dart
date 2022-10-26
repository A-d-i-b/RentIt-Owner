import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:househunt/models/asset_models.dart';

class FireBaseController {
  static Future uploadFilePg(int id, RxList<FileAsset> assets) async {
    for (var img in assets) {
      if (img.type == AssetType.photo) {
        String imgPath = img.file.path.split("/").last;
        Reference db = FirebaseStorage.instance.ref("Housing/$id/$imgPath");
        await db.putFile(img.file);
        FirebaseFirestore.instance
            .collection('housing')
            .doc('$id')
            .collection('photos')
            .doc()
            .set({'Url': await db.getDownloadURL(), 'name': imgPath});
      } else {
        String imgPath = img.file.path.split("/").last;
        Reference db = FirebaseStorage.instance.ref("Housing/$id/$imgPath");
        await db.putFile(img.file);
        FirebaseFirestore.instance
            .collection('housing')
            .doc('$id')
            .collection('videos')
            .doc()
            .set({'Url': await db.getDownloadURL(), 'name': imgPath});
      }
    }
  }

  static Future uploadFileFlat(int id, RxList<FileAsset> assets) async {
    for (var img in assets) {
      if (img.type == AssetType.photo) {
        String imgPath = img.file.path.split("/").last;
        Reference db = FirebaseStorage.instance.ref("Housing/$id/$imgPath");
        await db.putFile(img.file);
        FirebaseFirestore.instance
            .collection('housing')
            .doc('$id')
            .collection('photos')
            .doc()
            .set({'Url': await db.getDownloadURL(), 'name': imgPath});
      } else {
        String imgPath = img.file.path.split("/").last;
        Reference db = FirebaseStorage.instance.ref("Housing/$id/$imgPath");
        await db.putFile(img.file);
        FirebaseFirestore.instance
            .collection('housing')
            .doc('$id')
            .collection('videos')
            .doc()
            .set({'Url': await db.getDownloadURL(), 'name': imgPath});
      }
    }
  }

  static Future<String> uploadFileProfile(int id, String path) async {
    File img = File(path);
    // String imgPath = img.path.split("/").last;
    Reference db = FirebaseStorage.instance.ref("Users/$id.jpg");
    await db.putFile(img);
    String url = await db.getDownloadURL();
    FirebaseFirestore.instance.collection('users').doc('$id').set({'Url': url});
    return url;
  }

  static Widget display(int id) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('housing')
            .doc('$id')
            .collection('photos')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();

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
              imageUrl: '${snapshot.data?.docs[0]['Url']}',
              fit: BoxFit.fill,
            ),
          );
        });
  }

  static Future deleteHousing(int id) async {
    await FirebaseFirestore.instance.collection('housing').doc('$id').delete();
    // delete photos from storage
    Reference ref = FirebaseStorage.instance.ref("Housing/$id");
    await ref.listAll().then((dir) {
      for (var fileRef in dir.items) {
        fileRef.delete();
      }
    });
  }

  static Future<List<String>> getAssets(int id) async {
    final ref = FirebaseFirestore.instance
        .collection('housing')
        .doc('$id')
        .collection('photos');

    final List<String> urls = [];

    await ref.get().then((value) {
      urls.addAll(
        value.docs.map(
          (e) => e['Url'],
        ),
      );
    });

    return urls;
  }

  static Widget displayList() {
    int id23 = 104;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('housing')
          .doc('$id23')
          .collection('photos')
          .snapshots(),
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
                        snapshot.data?.docs[index]['Url'],
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      if (snapshot.data?.docs.length == 1) {
                        Get.snackbar("Error", "Atleast one image is required");
                      } else {
                        FirebaseStorage.instance
                            .ref(
                                "Housing/$id23/${snapshot.data?.docs[index]['name']}")
                            .delete();
                        snapshot.data?.docs[index].reference.delete();
                      }
                    },
                    icon: const Icon(Icons.cancel))
              ],
            );
          },
        );
      },
    );
  }
}
