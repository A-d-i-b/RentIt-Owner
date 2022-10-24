import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:househunt/controllers/flat_form_controller.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/pg_form_controller.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseController extends GetxController {
  final PgFormController pgFormController = Get.put(PgFormController());
  final FlatFormController flatFormController = Get.put(FlatFormController());

  Future uploadFilePg(int id) async {
    for (var img in pgFormController.assets) {
      if (img.type == 'photo') {
        String imgPath = img.file.path.split("/").last;
        Reference db = FirebaseStorage.instance.ref(
            "Housing/$id/$imgPath"); //TODO: instead of 1 we have to give id of the housing
        await db.putFile(img.file);
        FirebaseFirestore.instance
            .collection('housing')
            .doc('$id')
            .collection('photos')
            .doc()
            .set({'Url': await db.getDownloadURL()});
      } else {
        String imgPath = img.file.path.split("/").last;
        Reference db = FirebaseStorage.instance.ref(
            "Housing/$id/$imgPath"); //TODO: instead of 1 we have to give id of the housing
        await db.putFile(img.file);
        FirebaseFirestore.instance
            .collection('housing')
            .doc('$id')
            .collection('videos')
            .doc()
            .set({'Url': await db.getDownloadURL()});
      }
    }
  }

  Future uploadFileFlat(int id) async {
    for (var img in flatFormController.assets) {
      if (img.type == 'photo') {
        String imgPath = img.file.path.split("/").last;
        Reference db = FirebaseStorage.instance.ref(
            "Housing/$id/$imgPath"); //TODO: instead of 1 we have to give id of the housing
        await db.putFile(img.file);
        FirebaseFirestore.instance
            .collection('housing')
            .doc('$id')
            .collection('photos')
            .doc()
            .set({'Url': await db.getDownloadURL()});
      } else {
        String imgPath = img.file.path.split("/").last;
        Reference db = FirebaseStorage.instance.ref(
            "Housing/$id/$imgPath"); //TODO: instead of 1 we have to give id of the housing
        await db.putFile(img.file);
        FirebaseFirestore.instance
            .collection('housing')
            .doc('$id')
            .collection('videos')
            .doc()
            .set({'Url': await db.getDownloadURL()});
      }
    }
  }

  Future<String> uploadFileProfile(int id, String path) async {
    File img = File(path);
    // String imgPath = img.path.split("/").last;
    Reference db = FirebaseStorage.instance.ref("Users/$id.jpg");
    await db.putFile(img);
    String url = await db.getDownloadURL();
    FirebaseFirestore.instance.collection('users').doc('$id').set({'Url': url});
    return url;
  }

  Widget display(int id) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('housing')
            .doc('$id')
            .collection('photos')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          // return Container(
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     image: DecorationImage(
          //         fit: BoxFit.fill,
          //         image: NetworkImage('${snapshot.data?.docs[0]['Url']}')),
          //   ),
          // );
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
                      value: downloadProgress.progress),
                ),
              ),
              imageUrl: '${snapshot.data?.docs[0]['Url']}',
              fit: BoxFit.fill,
            ),
          );
        });
  }
}
