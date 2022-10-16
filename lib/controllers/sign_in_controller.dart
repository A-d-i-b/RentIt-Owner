import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  }

  void loginForm() async {
    // make a post request to the server with the form data

    buttonDisabled.value = true;

    await Future.delayed(const Duration(seconds: 2));

    buttonDisabled.value = false;
    return;
  }

  @override
  void onClose() {
    mobileController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
