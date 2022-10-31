import 'package:get/get.dart';
import 'package:househunt/controllers/firebase_controller.dart';
import 'package:househunt/controllers/user_controller.dart';
import 'package:househunt/http_connects/auth_controller.dart';

class OTPController extends GetxController {
  RxList<String> otp = <String>[].obs;

  final userController = Get.find<UserController>();
  final _apiProvider = AuthConnect();

  RxInt resendCodePressed = 0.obs;
  RxBool resendCodeDisabled = false.obs;
  RxInt counter = 0.obs;

  bool _disabled = false;
  RxBool loading = false.obs;

  void resendOtp() async {
    try {
      await _apiProvider.resendOtp(Get.arguments[0] as String);

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
      back();
    }
  }

  void appendNumber(String number) {
    if (otp.length < 6 && !_disabled) {
      otp.add(number);
    }
  }

  void countDown(int from) async {
    counter.value = from;
    for (int i = from; i >= 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      counter.value = i;
    }
  }

  void removeNumber() {
    if (otp.isNotEmpty && !_disabled) {
      otp.removeLast();
    }
  }

  void back() {
    if (Get.arguments != null) {
      Get.offAllNamed(Get.arguments[1]);
    }
  }

  @override
  void onInit() {
    ever(otp, (List<String> value) async {
      if (value.length == 6) {
        _disabled = true;
        loading.value = true;

        if (Get.arguments != null) {
          _apiProvider.verifyOtp({
            "otp": otp.join(),
            "phone": Get.arguments[0],
          }).then(
            (value) {
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
            },
          ).catchError(
            (e) {
              Get.snackbar(
                "Error",
                "Invalid OTP",
                snackPosition: SnackPosition.BOTTOM,
              );

              // clear otp
              otp.clear();

              _disabled = false;
              loading.value = false;
            },
          );
        }
      }
    });

    // every time otp requested set a timer
    // to disable resend code button
    ever(resendCodePressed, (int value) {
      resendCodeDisabled.value = true;

      countDown(timeToResend(value));

      resendCodeDisabled.value = false;
    });

    super.onInit();
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

  void submit() {}
}
