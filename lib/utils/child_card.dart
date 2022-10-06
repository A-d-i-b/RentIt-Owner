import 'package:flutter/material.dart';

class Clmcard extends StatelessWidget {
  final IconData cusicon;
  String a;
  Clmcard({required this.cusicon, required this.a});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          cusicon,
          color: Colors.white,
          size: 30,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          a,
          style: TextStyle(fontSize: 18, color: Colors.white),
        )
      ],
    );
  }
}
