import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final Color color;
  final Widget childCard;

  const ReusableCard({required this.color, required this.childCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.cyanAccent,
            blurRadius: 7,
            spreadRadius: 3,
          )
        ],
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: childCard,
    );
  }
}
