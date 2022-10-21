import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/user_controller.dart';
import 'package:househunt/http_connects/auth_controller.dart';

class SignUpController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mobileController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _apiProvider = AuthConnect();

  get formKey => _formKey;

  final UserController userController = Get.find<UserController>();

  RxBool buttonDisabled = false.obs;

  void submitForm() async {
    // make a post request to the server with the form data

    buttonDisabled.value = true;

    final response = {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "phone": mobileController.text,
      "password": passwordController.text,
    };

    _apiProvider.signUp(response).then((res) {
      final resBody = res.body;

      if (res.statusCode == 400) {
        if (resBody["error"]["message"].contains("Email")) {
          buttonDisabled.value = false;

          Get.snackbar(
            "Info",
            "User already exists",
            snackPosition: SnackPosition.BOTTOM,
          );

          Get.offAllNamed('/login');
        } else {
          buttonDisabled.value = false;
          Get.snackbar(
            "Error",
            "Please enter a valid phone number",
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }

      if (res.statusCode == 200) {
        userController.setUserFromJson(resBody["user"]);
        Get.offAllNamed('/otp',
            arguments: [resBody["user"]["phone"], 'sign-up']);
      }
    });
    // make a post request
    // final res = await postData(
    //   uri: REGISTER_URL,
    //   body: json.encoder.convert(response),
    // );

    // final Map<String, dynamic> resBody = await json.decode(res.body);

    // if (res.statusCode == 400) {
    //   if (resBody["error"]["message"].contains("Email")) {
    //     buttonDisabled.value = false;

    //     Get.snackbar(
    //       "Info",
    //       "User already exists",
    //       snackPosition: SnackPosition.BOTTOM,
    //     );

    //     Get.offAllNamed('/login');
    //   } else {
    //     buttonDisabled.value = false;
    //     Get.snackbar(
    //       "Error",
    //       "Please enter a valid phone number",
    //       snackPosition: SnackPosition.BOTTOM,
    //     );
    //   }
    // }

    // if (res.statusCode == 200) {
    // userController.setUserFromJson(resBody["user"]);
    // Get.offAllNamed('/otp', arguments: resBody["user"]["phone"]);
    // }

    buttonDisabled.value = false;
  }
}
