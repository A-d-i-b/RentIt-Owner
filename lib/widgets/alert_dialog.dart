import 'package:get/get.dart';
import 'package:flutter/material.dart';

Future<bool?> alertDialog({required String title, required String content}) {
  return Get.dialog<bool>(
    AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Text(title),
      content: Text(content),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(result: false);
          },
          child: const Text(
            "No",
            style: TextStyle(color: Colors.green),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          onPressed: () {
            Get.back(result: true);
          },
          child: const Text(
            "Yes",
          ),
        ),
      ],
    ),
  );
}
