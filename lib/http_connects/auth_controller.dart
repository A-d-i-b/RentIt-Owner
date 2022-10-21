import 'package:get/get_connect.dart';
import 'package:househunt/secrets.dart';

class AuthConnect extends GetConnect {
  Future verifyOtp(Map body) async {
    final res = await post(OTP_URL, body);

    if (res.isOk) {
      return res.body;
    } else {
      throw Exception('Failed to verify otp');
    }
  }

  Future signIn(Map body) async {
    final res = await post(LOGIN_URL, body);

    if (res.isOk) {
      return res.body;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future signUp(Map body) async {
    final res = await post(REGISTER_URL, body);

    return res;
  }
}
