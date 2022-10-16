import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/sign_up_controller.dart';
import 'package:househunt/theme/base_theme.dart';
import 'package:househunt/utils/string_utils.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  final SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Obx(
            () => (signUpController.buttonDisabled.value)
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
              "Let's Start",
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
            child: Stack(
              children: [
                SizedBox(
                  width: Get.width,
                  height: Get.height * 0.6,
                  child: Container(
                    decoration: const BoxDecoration(
                      // color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      height: Get.height * 60 / 100,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        // rounded
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        boxShadow: const [
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
                          key: signUpController.formKey,
                          child: ListView(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,

                            padding: const EdgeInsets.all(0),
                            children: [
                              // heading SignUp
                              Text(
                                "Sign Up",
                                style: Get.textTheme.headline4!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              // name field
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: Get.width / 2.75,
                                    child: SignUpPageField(
                                      labelText: 'First Name',
                                      controller:
                                          signUpController.firstNameController,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width / 2.75,
                                    child: SignUpPageField(
                                      labelText: 'Last Name',
                                      controller:
                                          signUpController.lastNameController,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              SignUpPageField(
                                labelText: 'Mobile No.',
                                textInputType: TextInputType.phone,
                                validator: RegExp(r"^(\+\d{1,3}[- ]?)?\d{10}$"),
                                controller: signUpController.mobileController,
                              ),
                              const SizedBox(height: 10),
                              EmailField(
                                controller: signUpController.emailController,
                              ),
                              const SizedBox(height: 10),
                              PasswordField(
                                passwordController:
                                    signUpController.passwordController,
                                confirmPasswordController:
                                    signUpController.confirmPasswordController,
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              TextButton(
                                onPressed: () {
                                  Get.offAllNamed('/login');
                                },
                                child: const Text(
                                  'Already Registered?',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    // underline
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          onPressed: () {
            print(signUpController.buttonDisabled.value);
            if (signUpController.buttonDisabled.value) {
              return;
            }

            if (!signUpController.formKey.currentState!.validate()) {
              return;
            }

            signUpController.submitForm();
          },
          backgroundColor: Colors.black
              .withOpacity(signUpController.buttonDisabled.value ? 0.5 : 1),
          elevation: 2,
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
    );
  }
}

class SignUpPageField extends StatelessWidget {
  const SignUpPageField({
    Key? key,
    required this.labelText,
    this.textInputType = TextInputType.text,
    required this.controller,
    this.validator,
  }) : super(key: key);

  final String labelText;

  final TextInputType textInputType;
  final TextEditingController controller;
  final RegExp? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: primary,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
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
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $labelText';
        }

        if (validator != null && !validator!.hasMatch(value)) {
          return 'Please enter valid $labelText';
        }

        return null;
      },
    );
  }
}

class EmailField extends StatelessWidget {
  const EmailField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(
          color: Colors.black,
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
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Field is required';
        }
        return isValidEmail(value) ? null : 'Invalid Email';
      },
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
    required this.passwordController,
    required this.confirmPasswordController,
  }) : super(key: key);

  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.passwordController,
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
            labelText: 'Password',
            labelStyle: const TextStyle(
              color: Colors.black,
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: primary,
              ),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: primary,
              ),
            ),
            errorMaxLines: 2,
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Field is required';
            }

            if (!isValidPassword(value)) {
              return 'Minimum eight characters, at least one letter, one number and one special character';
            }

            return null;
          },
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: widget.confirmPasswordController,
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
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: primary,
              ),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
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
            if (widget.confirmPasswordController.value.text !=
                widget.passwordController.value.text) {
              return 'Password does not match';
            }

            return null;
          },
        )
      ],
    );
  }
}
