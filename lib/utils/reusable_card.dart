import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final Color color;
  final Widget childCard;

  const ReusableCard({required this.color, required this.childCard, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: childCard,
      ),
    );
  }
}
// Container(
//       padding: const EdgeInsets.all(20),
//       margin: const EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         boxShadow: const [
//           BoxShadow(
//             offset: Offset(3, 3),
//             spreadRadius: -3,
//             blurRadius: 10,
//             color: Colors.grey,
//           )
//         ],
//         borderRadius: BorderRadius.circular(10),
//         color: color,
//       ),
//       child: childCard,
//     );