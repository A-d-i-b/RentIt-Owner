import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KeyController extends GetxController {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  get key => _key;
}
