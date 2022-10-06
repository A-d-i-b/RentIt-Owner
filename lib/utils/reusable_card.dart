import 'package:flutter/material.dart';

class Reusablecard extends StatelessWidget {
  final Color colour;
  final Widget childcard;

  Reusablecard({required this.colour, required this.childcard});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: childcard,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent,
            blurRadius: 7,
            spreadRadius: 3,
          )
        ],
        borderRadius: BorderRadius.circular(10),
        color: colour,
      ),
    );
  }
}
