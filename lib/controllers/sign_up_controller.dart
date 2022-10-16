import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/secrets.dart';
import 'package:househunt/utils/http_util.dart';

class SignUpController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();

  RxBool buttonDisabled = false.obs;

  void submitForm() async {
    // make a post request to the server with the form data

    buttonDisabled.value = true;

    await Future.delayed(const Duration(seconds: 2));

    buttonDisabled.value = false;
    return;

    final response = {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "phone": mobileController.text,
      "email": emailController.text,
      "password": passwordController.text,
    };

    // make a post request
    final res = await signUpUser(
      uri: REGISTER_URL,
      body: json.encoder.convert(response),
    );

    final Map<String, dynamic> resBody = await json.decode(res.body);

    if (res.statusCode == 400) {
      if (resBody["error"]["message"].contains("Email")) {
        buttonDisabled.value = false;
        Get.offAllNamed('/login');
      } else {
        buttonDisabled.value = false;
        Get.snackbar(
          "Error",
          "Please enter a valid phone number",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      buttonDisabled.value = false;
    }
  }

  @override
  void onClose() {
    // delete the controllers, remove global key
    firstNameController.dispose();
    lastNameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.onClose();
  }
}
