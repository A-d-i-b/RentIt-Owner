import 'dart:convert';

import 'package:get/get.dart';
import 'package:househunt/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  Rx<UserModel> user =
      UserModel(id: 0, firstName: 'Loading', lastName: '', phone: '...').obs;

  String jwt = '';

  Rx<XFile> updatedImage = XFile('').obs;

  set JWT(String token) {
    jwt = token;

    saveLocal();
  }

  void saveLocal() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('jwt', jwt);
    prefs.setString('user', jsonEncode(user.value.toJson()));
  }

  void setUser(Map<String, dynamic> data) {}

  @override
  void onReady() async {
    final prefs = await SharedPreferences.getInstance();

    final jwt = prefs.getString('jwt');

    if (jwt != null) {
      JWT = jwt;
    }

    final user = prefs.getString('user');

    if (user != null) {
      this.user.value = UserModel.fromJson(json: jsonDecode(user));
    }

    if (user != null && jwt != null) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/sign-in');
    }

    super.onReady();
  }

  void setUserFromJson(Map<String, dynamic> data) {
    user.update((val) {
      if (val == null) return;
      val.id = data['id'];
      val.firstName = data['firstName'];
      val.lastName = data['lastName'];
      val.phone = data['phone'];
      val.imageUrl = data['image_url'];
    });
  }
}
