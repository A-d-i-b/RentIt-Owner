import 'package:firebase_storage/firebase_storage.dart';
import 'package:househunt/controllers/flat_form_controller.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/pg_form_controller.dart';
import 'package:househunt/controllers/user_controller.dart';
import 'dart:io';

class FireBaseController extends GetxController {
  final PgFormController pgFormController = Get.put(PgFormController());
  final UserController userController = Get.put(UserController());
  final FlatFormController flatFormController = Get.put(FlatFormController());

  RxList<String> pgPath = <String>[].obs;
  RxList<String> flatPath = <String>[].obs;

  Future uploadFile(String id) async {
    for (var img in pgFormController.assets) {
      String imgPath = img.path.split("/").last;
      Reference db = FirebaseStorage.instance.ref(
          "Housing/$id/$imgPath"); //TODO: instead of 1 we have to give id of the housing
      await db.putFile(img);
      // pgPath.add(await db.getDownloadURL());
    }
  }

  // Future uploadFileFlat() async {
  //   for (var img in flatFormController.assets) {
  //     String imgPath = img.path.split("/").last;
  //     Reference db = FirebaseStorage.instance.ref(
  //         "${userController.user.value.phone}/Flat/1/$imgPath"); //TODO: instead of 1 we have to give id of the housing
  //     await db.putFile(img);
  //     // flatPath.add(await db.getDownloadURL());
  //   }
  // }

  Future uploadFileProfile(String id) async {
    File img = File(userController.updatedImage.value.path);
    // String imgPath = img.path.split("/").last;
    Reference db = FirebaseStorage.instance.ref("Users/$id.jpg");
    await db.putFile(img);
    userController.user.update((val) async {
      if (val != null) {
        val.imageUrl = await db.getDownloadURL();
      }
    });
  }
}
