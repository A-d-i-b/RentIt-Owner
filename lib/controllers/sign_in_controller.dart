import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/sign_up_controller.dart';

class SignInController extends GetxController {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final SignUpController signUpController = Get.put(SignUpController());
  RxBool buttonDisabled = false.obs;
  void trySubmit() {
    final isvalid = signUpController.formKey.currentState?.validate();
    if (Get.context != null) {
      FocusScope.of(Get.context!).unfocus();
    }
    if (isvalid!) {
      signUpController.formKey.currentState?.save();
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
