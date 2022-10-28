import 'package:get/get.dart';
import 'package:flutter/material.dart';

class UpdateController extends GetxController {
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  RxBool buttonDisabled = false.obs;
  final _formKey = GlobalKey<FormState>();
  get formKey => _formKey;
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
  }
}
