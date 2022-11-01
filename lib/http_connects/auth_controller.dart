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

  Future updateUser(Map body, int id, String jwt) async {
    final res = await put(
      '$USER_URL/$id',
      body,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );

    if (res.isOk) {
      return res.body;
    } else {
      throw Exception('Failed to update user');
    }
  }

  Future getUser(int id) async {
    final res = await get('$USER_URL/$id');

    if (res.isOk) {
      return res.body;
    } else {
      throw Exception('Failed to get user');
    }
  }

  Future resendOtp(
    String phone,
  ) async {
    final res = await post(
      RESEND_OTP_URL,
      {'phone': phone},
    );

    if (res.isOk) {
      return res.body;
    } else if (res.body['error']['name'] == 'ValidationError') {
      throw Exception('Phone number is not valid');
    } else if (res.body['error']['name'] == 'ApplicationError') {
      throw Exception('Phone number is not registered');
    } else {
      throw Exception('Failed to resend otp');
    }
  }

  Future forgotPassword(String phone) async {
    final res = await post(FORGOT_PASSWORD_URL, {'phone': phone});

    if (res.isOk) {
      return res.body;
    } else {
      throw Exception('No user found with this phone number');
    }
  }

  Future resetPassword(Map body) async {
    final res = await post(RESET_PASSWORD_URL, body);

    if (res.isOk) {
      return res.body;
    } else {
      throw Exception('Failed to reset password');
    }
  }

  Future resendResetOtp(String phone) {
    return post(
      RESEND_RESET_OTP_URL,
      {'phone': phone},
    );
  }
}
