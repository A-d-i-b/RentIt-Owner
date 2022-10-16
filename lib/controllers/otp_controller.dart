import 'package:get/get.dart';

class OTPController extends GetxController {
  RxList<String> otp = <String>[].obs;

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
    ever(otp, (List<String> value) {
      if (value.length == 6) {
        _disabled = true;
        loading.value = true;

        // Future.delayed(const Duration(seconds: 2), () {
        //   loading.value = false;
        //   _disabled = false;
        // });

        // make http request to verify otp
      }
    });

    super.onInit();
  }

  void submit() {}
}
