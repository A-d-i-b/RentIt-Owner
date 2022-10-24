import 'package:firebase_storage/firebase_storage.dart';
import 'package:househunt/controllers/flat_form_controller.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/pg_form_controller.dart';
import 'package:househunt/controllers/user_controller.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseController extends GetxController {
  final PgFormController pgFormController = Get.put(PgFormController());
  final UserController userController = Get.put(UserController());
  final FlatFormController flatFormController = Get.put(FlatFormController());

  Future uploadFilePg(int id) async {
    for (var img in pgFormController.assets) {
      String imgPath = img.file.path.split("/").last;
      Reference db = FirebaseStorage.instance.ref(
          "Housing/$id/$imgPath"); //TODO: instead of 1 we have to give id of the housing
      await db.putFile(img.file);
      FirebaseFirestore.instance
          .collection('housing')
          .doc('$id')
          .collection(img.type)
          .doc()
          .set({'Url': await db.getDownloadURL()});
    }
  }

  Future uploadFileFlat(int id) async {
    for (var img in flatFormController.assets) {
      String imgPath = img.file.path.split("/").last;
      Reference db = FirebaseStorage.instance.ref(
          "Housing/$id/$imgPath"); //TODO: instead of 1 we have to give id of the housing
      await db.putFile(img.file);
      FirebaseFirestore.instance
          .collection('housing')
          .doc('$id')
          .collection(img.type)
          .doc()
          .set({'Url': await db.getDownloadURL()});
    }
  }

  Future uploadFileProfile(int id) async {
    File img = File(userController.updatedImage.value.path);
    // String imgPath = img.path.split("/").last;
    Reference db = FirebaseStorage.instance.ref("Users/$id.jpg");
    await db.putFile(img);

    userController.user.update((val) async {
      if (val != null) {
        String url = await db.getDownloadURL();
        FirebaseFirestore.instance
            .collection('users')
            .doc('$id')
            .set({'Url': url});
        userController.image.value = url;
      }
    });
  }

  // return url
}

// String getUrl() {
//   var data2 = '';
//   FirebaseFirestore.instance
//       .collection('users')
//       .doc('${userController.user.value.id}')
//       .get()
//       .then((DocumentSnapshot doc) {
//     final data = (doc.data() as Map<String, dynamic>)['Url'];
//     data2 = data;
//     userController.image.value = data;
//   });
//   return data2;
// }
