import 'package:flutter/material.dart';

class ClmCard extends StatelessWidget {
  final IconData cusIcon;
  final String a;
  const ClmCard({required this.cusIcon, required this.a, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          cusIcon,
          color: Colors.white,
          size: 30,
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          a,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        )
      ],
    );
  }
}
