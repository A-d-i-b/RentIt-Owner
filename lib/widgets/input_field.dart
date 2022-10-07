import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/pg_form_controller.dart';

class Field extends StatelessWidget {
  Field({
    Key? key,
    required this.heading,
    required this.hint,
    this.keyboardType,
    this.maxLines,
    required this.onChange,
  }) : super(key: key);

  final String heading;
  final String hint;
  final dynamic keyboardType;
  final int? maxLines;
  final Function onChange;

  final PgFormController pgFormController = Get.put(PgFormController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 16),
          ),
          onChanged: (value) {
            onChange(value);
          },
        ),
        const SizedBox(
          height: 19,
        ),
      ],
    );
  }
}
