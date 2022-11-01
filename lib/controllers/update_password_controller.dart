import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:househunt/controllers/firebase_controller.dart';
import 'package:househunt/controllers/user_controller.dart';
import 'package:househunt/http_connects/auth_controller.dart';

class UpdateController extends GetxController {
  final _apiProvider = AuthConnect();
  final UserController userController = Get.find<UserController>();

  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController otp = TextEditingController();

  RxBool buttonDisabled = false.obs;
  final _formKey = GlobalKey<FormState>();
  get formKey => _formKey;

  RxInt resendCodePressed = 0.obs;
  RxBool resendCodeDisabled = false.obs;
  RxInt counter = 0.obs;

  Future countDown(int from) async {
    counter.value = from;
    for (int i = from; i >= 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      counter.value = i;
    }
  }

  @override
  void onInit() {
    ever(resendCodePressed, (int value) {
      resendCodeDisabled.value = true;
      print('resendCodePressed: $value');

      countDown(timeToResend(value))
          .then((value) => resendCodeDisabled.value = false);
    });

    super.onInit();
  }

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

    try {
      buttonDisabled.value = true;

      final body = {
        "password": newPassword.text,
        "passwordConfirmation": confirmPassword.text,
        "code": otp.text
      };

      final value = await _apiProvider.resetPassword(body);

      Get.snackbar(
        'Success',
        'Password updated successfully',
        snackPosition: SnackPosition.BOTTOM,
      );

      userController.setJwt = value["jwt"];

      userController.setUser(value["user"]);

      FireBaseController.getUserImageUrl(value["user"]["id"]).then(
        (value) {
          userController.image.value = value ?? '';
          Get.offAllNamed('/home');
        },
      );
      userController.saveLocal();

      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      buttonDisabled.value = false;
    }
  }

  void resendOtp() async {
    try {
      await _apiProvider.resendResetOtp(Get.arguments[0] as String);

      Get.snackbar(
        'Sent OTP',
        'OTP sent to ${Get.arguments[0]}',
        snackPosition: SnackPosition.BOTTOM,
      );

      resendCodePressed.value += 1;
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );

      Get.offAllNamed('/sign-in');
    }
  }

  int timeToResend(int times) {
    if (times == 0) {
      return 30;
    } else if (times == 1) {
      return 30;
    } else if (times == 2) {
      return 60;
    } else {
      return 120;
    }
  }
}
