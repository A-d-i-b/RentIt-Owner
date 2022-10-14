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
          Image.asset(
            'images/signup-bg.png',
            fit: BoxFit.fill,
            width: Get.width,
            height: Get.height,
          ),
          Container(
            width: Get.width,
            height: Get.height,
            color: Colors.transparent,
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
            child: Container(
              height: Get.height * 60 / 100,
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
                      const SignUpPageField(
                        labelText: 'Name',
                      ),
                      const SizedBox(height: 10),
                      const SignUpPageField(
                        labelText: 'Mobile No.',
                        textInputType: TextInputType.phone,
                      ),
                      const SizedBox(height: 10),
                      EmailField(
                        controller: signUpController.email,
                      ),
                      const SizedBox(height: 10),
                      PasswordField(
                        passwordController: signUpController.password,
                        confirmPasswordController:
                            signUpController.confirmPassword,
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      TextButton(
                        onPressed: () {},
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
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (signUpController.formKey.currentState!.validate()) {
            print('validated');
          }

          signUpController.submitForm();
        },
        backgroundColor: Colors.black,
        elevation: 2,
        child: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
          size: 32,
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
  }) : super(key: key);

  final String labelText;

  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // keyboard type
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
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $labelText';
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
          ),
          validator: (value) {
            print(
                "${widget.confirmPasswordController.value.text} ${widget.passwordController.value.text}");

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
