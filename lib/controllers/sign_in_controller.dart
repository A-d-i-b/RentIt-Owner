import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/user_controller.dart';
import 'package:househunt/http_connects/auth_controller.dart';

class SignInController extends GetxController {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _apiProvider = AuthConnect();

  final UserController userController = Get.find<UserController>();

  final _formKey = GlobalKey<FormState>();

  get formKey => _formKey;

  RxBool buttonDisabled = false.obs;
  void trySubmit() async {
    final isValid = _formKey.currentState?.validate();
    if (Get.context != null) {
      FocusScope.of(Get.context!).unfocus();
    }
    if (isValid!) {
      _formKey.currentState?.save();
    } else {
      return;
    }

    buttonDisabled.value = true;

    final response = {
      "identifier": mobileController.text,
      "password": passwordController.text,
    };

    _apiProvider.signIn(response).then((resBody) async {
      userController.setUserFromJson(resBody["user"]);

      if (resBody["user"]["blocked"] == true) {
        Get.snackbar(
          "Error",
          "Your account has been blocked",
          snackPosition: SnackPosition.BOTTOM,
        );

        buttonDisabled.value = false;
        return;
      }

      if (resBody["user"]["confirmed"] == false) {
        Get.offAllNamed('/otp',
            arguments: [resBody["user"]["phone"], 'sign-in']);
      } else {
        final docRef = FirebaseFirestore.instance
            .collection('users')
            .doc('${userController.user.value.id}');
        final value = await docRef.get();
        print(userController.user.value.id);
        if (value.exists) {
          userController.image.value = value.data()!['Url'];
        }
        print(userController.user.value.imageUrl);

        userController.JWT = resBody["jwt"];
        Get.offAllNamed('/home');
      }
    }).catchError((e) {
      Get.snackbar(
        "Error",
        "Invalid credentials",
        snackPosition: SnackPosition.BOTTOM,
      );
    }).whenComplete(() {
      buttonDisabled.value = false;
    });

    // final res = await postData(
    //   uri: LOGIN_URL,
    //   body: json.encoder.convert(response),
    // );

    // final Map<String, dynamic> resBody = await json.decode(res.body);

    // if (res.statusCode == 200) {
    // userController.setUserFromJson(resBody["user"]);

    // if (resBody["user"]["blocked"] == true) {
    //   Get.snackbar(
    //     "Error",
    //     "Your account has been blocked",
    //     snackPosition: SnackPosition.BOTTOM,
    //   );

    //   buttonDisabled.value = false;
    //   return;
    // }

    // if (resBody["user"]["confirmed"] == false) {
    //   Get.offAllNamed('/otp', arguments: resBody["user"]["phone"]);
    // } else {
    //   userController.JWT = resBody["jwt"];
    //   Get.offAllNamed('/home');
    // }
    // } else {
    // Get.snackbar(
    //   "Error",
    //   "Invalid credentials",
    //   snackPosition: SnackPosition.BOTTOM,
    // );
    // }

    buttonDisabled.value = false;
    return;
  }
}
