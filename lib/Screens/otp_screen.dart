import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/otp_controller.dart';

class OTPScreen extends StatelessWidget {
  OTPScreen({Key? key}) : super(key: key);
  final OTPController otpController = Get.put(OTPController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(
            'images/otpscreen-bg.png',
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
              "Code\nVerification",
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
              height: Get.height * 70 / 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(1),
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
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Enter the 6 digit code sent to your phone number",
                          style: Get.textTheme.caption!.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (var i = 0; i < 6; i++)
                                OtpNumber(
                                  otpController.otp.length <= i
                                      ? ""
                                      : otpController.otp[i],
                                  highlighted:
                                      otpController.otp.length - 1 == i,
                                )
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OtpButton("1", onPressed: () {
                              otpController.appendNumber("1");
                            }),
                            OtpButton("2", onPressed: () {
                              otpController.appendNumber("2");
                            }),
                            OtpButton("3", onPressed: () {
                              otpController.appendNumber("3");
                            }),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OtpButton("4", onPressed: () {
                              otpController.appendNumber("4");
                            }),
                            OtpButton("5", onPressed: () {
                              otpController.appendNumber("5");
                            }),
                            OtpButton("6", onPressed: () {
                              otpController.appendNumber("6");
                            }),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OtpButton("7", onPressed: () {
                              otpController.appendNumber("7");
                            }),
                            OtpButton("8", onPressed: () {
                              otpController.appendNumber("8");
                            }),
                            OtpButton("9", onPressed: () {
                              otpController.appendNumber("9");
                            }),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 80),
                            OtpButton("0", onPressed: () {
                              otpController.appendNumber("0");
                            }),
                            DeleteButton(
                              onPressed: () {
                                otpController.removeNumber();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => (otpController.loading.value)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const Center(),
          ),
        ],
      ),
    );
  }
}

class OtpButton extends StatelessWidget {
  final String text;
  const OtpButton(this.text, {Key? key, this.onPressed}) : super(key: key);

  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.1860,
      height: Get.width * 0.17,
      child: ElevatedButton(
        onPressed: () {
          if (onPressed != null) {
            onPressed!();
          }
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.white,

          // rounded rectangle
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
          shadowColor: Colors.black26,
          padding: const EdgeInsets.all(10),
        ),
        child: Text(
          text,
          style: Get.textTheme.headline4!.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
      ),
    );
  }
}

class OtpNumber extends StatelessWidget {
  const OtpNumber(this.text, {Key? key, this.highlighted = false})
      : super(key: key);

  final String text;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 8,
      height: Get.width / 7.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: !highlighted ? Colors.grey[300]! : Colors.blue,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: Get.textTheme.headline4!.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton({Key? key, this.onPressed}) : super(key: key);
  final Function? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 70,
      child: ElevatedButton(
        onPressed: () {
          if (onPressed != null) {
            onPressed!();
          }
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.white,

          // rounded rectangle
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
          shadowColor: Colors.black26,
          padding: const EdgeInsets.all(10),
        ),
        child: const Icon(
          Icons.backspace_rounded,
          color: Colors.black,
          size: 30,
        ),
      ),
    );
  }
}
