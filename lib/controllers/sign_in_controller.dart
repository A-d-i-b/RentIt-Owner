import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/secrets.dart';

import '../utils/http_util.dart';

class SignInController extends GetxController {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  get formKey => _formKey;

  RxBool buttonDisabled = false.obs;
  void trySubmit() {
    final isValid = _formKey.currentState?.validate();
    if (Get.context != null) {
      FocusScope.of(Get.context!).unfocus();
    }
    if (isValid!) {
      _formKey.currentState?.save();
    }
    print(mobileController.text);
    print(passwordController.text);
  }

  void loginForm() async {
    // make a post request to the server with the form data

    buttonDisabled.value = true;

    final response = {
      "phone": mobileController.text,
      "password": passwordController.text,
    };

    final res = await postData(
      uri: LOGIN_URL,
      body: json.encoder.convert(response),
    );

    final Map<String, dynamic> resBody = await json.decode(res.body);

    buttonDisabled.value = false;
    return;
  }
}
