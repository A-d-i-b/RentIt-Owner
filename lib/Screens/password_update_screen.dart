import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/update_password_controller.dart';

import '../theme/base_theme.dart';
import '../utils/string_utils.dart';

class PasswordUpdate extends StatefulWidget {
  const PasswordUpdate({Key? key}) : super(key: key);

  @override
  State<PasswordUpdate> createState() => _PasswordUpdateState();
}

class _PasswordUpdateState extends State<PasswordUpdate> {
  final UpdateController updateController = Get.put(UpdateController());
  bool _obscureText = true;
  bool _obscureText1 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Obx(
          () => FloatingActionButton(
            onPressed: () async {
              if (updateController.buttonDisabled.value) {
                return;
              }
              updateController.trySubmit();
              // Get.toNamed('/home');
            },
            backgroundColor: Colors.black
                .withOpacity(updateController.buttonDisabled.value ? 0.5 : 1),
            elevation: 2,
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Stack(children: [
          Image.asset(
            'images/signup-bg.png',
            fit: BoxFit.fill,
            width: Get.width,
            height: Get.height,
          ),
          Positioned(
            top: Get.height * 0.1,
            left: Get.width * 0.1,
            child: Text(
              "Update\nPassword",
              style: Get.textTheme.headline3!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: Get.height * .5,
              decoration: const BoxDecoration(
                color: tri,
                // rounded
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Form(
                  key: updateController.formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        obscureText: _obscureText1,
                        controller: updateController.newPassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field is required';
                          }
                          if (!isValidPassword(value)) {
                            return 'Minimum eight characters, at least one letter, one number and one special character';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: _obscureText1
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _obscureText1 = !_obscureText1;
                                });
                              },
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: primary,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: primary,
                              ),
                            ),
                            errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            focusedErrorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            labelText: 'New Password'),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: updateController.confirmPassword,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: _obscureText
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          labelText: 'Confirm Password',
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: primary,
                            ),
                          ),
                          errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: primary,
                            ),
                          ),
                          focusedErrorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (updateController.newPassword.value.text !=
                              updateController.confirmPassword.value.text) {
                            return 'Password does not match';
                          }

                          return null;
                        },
                      ),

                      // otp field
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: updateController.otp,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field is required';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: primary,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: primary,
                            ),
                          ),
                          errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          focusedErrorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          labelText: 'OTP',
                        ),
                      ),
                      // resend otp
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(
                            () => TextButton(
                              onPressed: () {
                                if (updateController.resendCodeDisabled.value) {
                                  return;
                                }
                                updateController.resendOtp();
                              },
                              child: Text(
                                "Resend code ${updateController.counter.value != 0 ? "(${updateController.counter.value}s)" : ""}",
                                style: Get.textTheme.bodyLarge!.copyWith(
                                  color:
                                      updateController.resendCodeDisabled.value
                                          ? Colors.grey[600]
                                          : const Color(0xFF654BD8),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ]));
  }
}
