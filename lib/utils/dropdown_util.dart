import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> generateItems(List<String> items) {
  List<DropdownMenuItem<String>> generatedItems = [];

  for (String item in items) {
    generatedItems.add(
      DropdownMenuItem(
        value: item,
        child: Center(
          child: Text(item),
        ),
      ),
    );
  }

  return generatedItems;
}
