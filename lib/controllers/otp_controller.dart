import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPController extends GetxController {
  final digit0Controller = TextEditingController();
  final digit1Controller = TextEditingController();
  final digit2Controller = TextEditingController();
  final digit3Controller = TextEditingController();
  final digit4Controller = TextEditingController();
  final digit5Controller = TextEditingController();

  RxBool buttonDisabled = false.obs;
}
