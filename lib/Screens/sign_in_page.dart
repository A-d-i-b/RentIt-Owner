import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:househunt/controllers/sign_in_controller.dart';
import 'package:get/get.dart';
import 'package:househunt/theme/base_theme.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);
  final SignInController signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        signInController.trySubmit();
      }),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Obx(
            () => (signInController.buttonDisabled.value)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const Center(),
          ),
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
              "Welcome\nBack!!",
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
              child: Stack(children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      height: Get.height * .6,
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
                            key: signInController.formKey,
                            child: ListView(
                              padding: const EdgeInsets.all(0),
                              children: [
                                Text(
                                  "Sign In",
                                  style: Get.textTheme.headline4!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 25),
                                TextFormField(
                                  validator: (value) {
                                    final validator =
                                        RegExp(r"^(\+\d{1,3}[- ]?)?\d{10}$");
                                    if (value!.isEmpty) {
                                      return 'Please enter Phone No.';
                                    }

                                    if (!validator.hasMatch(value)) {
                                      return 'Please enter valid Phone No.';
                                    }

                                    return null;
                                  },
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
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
                                      errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                      focusedErrorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                      labelText: 'Phone Number'),
                                ),
                                const SizedBox(height: 25),
                                TextFormField(
                                  decoration: const InputDecoration(
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
                                      errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                      focusedErrorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                      labelText: 'Password'),
                                  obscureText: true,
                                ),
                                const SizedBox(height: 25),
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          // underline
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        Get.toNamed('/sign-up');
                                      },
                                      child: Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          // underline
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
                    ),
                  ),
                ),
              ])),
        ],
      ),
    );
  }
}
