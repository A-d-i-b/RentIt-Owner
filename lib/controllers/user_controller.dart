import 'dart:convert';

import 'package:get/get.dart';
import 'package:househunt/controllers/firebase_controller.dart';
import 'package:househunt/http_connects/auth_controller.dart';
import 'package:househunt/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  Rx<UserModel> user =
      UserModel(id: 0, firstName: 'Loading', lastName: '', phone: '...').obs;

  final AuthConnect _apiProvider = AuthConnect();

  String jwt = '';
  Rx<String> image = ''.obs;
  Rx<XFile> updatedImage = XFile('').obs;

  RxBool isUpdating = false.obs;

  set setJwt(String token) {
    jwt = token;
    saveLocal();
  }

  Future updateUser(Map body) async {
    _apiProvider.updateUser(body, user.value.id, jwt).then((value) {
      user.update((val) {
        val!.firstName = value['firstName'];
        val.lastName = value['lastName'];
        val.phone = value['phone'];

        if (value['confirmed'] != true) {
          signOut();
          Get.offAllNamed('/otp', arguments: [value['phone'], 'sign-in']);
        } else {
          saveLocal();
          Get.back();
        }
      });
    }).catchError((err) {
      Get.snackbar('Error', err.toString());
    });
  }

  void saveLocal() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('jwt', jwt);
    prefs.setString('user', jsonEncode(user.value.toJson()));
  }

  void setUser(Map<String, dynamic> data) {
    user.value = UserModel.fromJson(json: data);
    saveLocal();
  }

  void signOut() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('jwt');
    await prefs.remove('user');

    user.value =
        UserModel(id: 0, firstName: 'Loading', lastName: '', phone: '...');
    jwt = '';
    image.value = '';
    updatedImage.value = XFile('');
  }

  void fetchUser() async {
    _apiProvider.getUser(user.value.id).then((value) {
      if (value['confirmed'] != true) {
        signOut();
        Get.toNamed('/sign-in');
        return;
      }

      user.update((val) {
        val!.firstName = value['firstName'];
        val.lastName = value['lastName'];
        val.phone = value['phone'];
      });
    }).catchError((err) {
      Get.snackbar('Error', err.toString());
    });
  }

  @override
  void onReady() async {
    final prefs = await SharedPreferences.getInstance();

    final jwt = prefs.getString('jwt');

    if (jwt != null) {
      setJwt = jwt;
    }

    final user = prefs.getString('user');

    if (user != null) {
      this.user.value = UserModel.fromJson(json: jsonDecode(user));
    }

    if (user != null && jwt != null) {
      image.value =
          await FireBaseController.getUserImageUrl(this.user.value.id) ?? '';
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
