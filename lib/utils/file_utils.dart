import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<Map<String, dynamic>> getJsonFromAsset(String path) async {
  final manifestContent = await DefaultAssetBundle.of(Get.context!)
      .loadString('AssetManifest.json');

  final manifest = json.decode(manifestContent) as Map<String, dynamic>;

  final reqJson = manifest.keys.where((p) => p == path).toList().first;

  final map = json.decode(
    await DefaultAssetBundle.of(Get.context!).loadString(reqJson),
  ) as Map<String, dynamic>;

  return map;
}
