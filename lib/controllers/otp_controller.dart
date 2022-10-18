import 'dart:convert';

import 'package:get/get.dart';
import 'package:househunt/controllers/user_controller.dart';
import 'package:househunt/secrets.dart';
import 'package:househunt/utils/http_util.dart';

class OTPController extends GetxController {
  RxList<String> otp = <String>[].obs;

  final userController = Get.find<UserController>();

  bool _disabled = false;
  RxBool loading = false.obs;

  void appendNumber(String number) {
    if (otp.length < 6 && !_disabled) {
      otp.add(number);
    }
  }

  void removeNumber() {
    if (otp.isNotEmpty && !_disabled) {
      otp.removeLast();
    }
  }

  @override
  void onInit() {
    ever(otp, (List<String> value) async {
      if (value.length == 6) {
        _disabled = true;
        loading.value = true;

        // Future.delayed(const Duration(seconds: 2), () {
        //   loading.value = false;
        //   _disabled = false;
        // });

        // make http request to verify otp
        if (Get.arguments != null) {
          final res = await postData(
            uri: OTP_URL,
            body: json.encode(
              {
                "otp": otp.join(),
                "phone": Get.arguments,
              },
            ),
          );

          if (res.statusCode == 200) {
            userController.JWT = json.decode(res.body)["jwt"];
            Get.offAllNamed('/home');
          } else {
            Get.snackbar(
              "Error",
              "Invalid OTP",
              snackPosition: SnackPosition.BOTTOM,
            );

            loading.value = false;
          }
        }
      }
    });

    super.onInit();
  }

  void submit() {}
}
