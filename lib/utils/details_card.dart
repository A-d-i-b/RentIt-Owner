import 'package:flutter/material.dart';
import 'package:househunt/theme/base_theme.dart';

class DetailCard extends StatefulWidget {
  const DetailCard({Key? key, required this.detail, required this.icon})
      : super(key: key);
  final String detail;
  final IconData icon;
  @override
  State<DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Icon(
            widget.icon,
            color: primary,
            size: 20,
          ),
          SizedBox(width: 30),
          Text(
            widget.detail,
            style: TextStyle(fontSize: 20, color: secondary),
          ),
        ]),
        SizedBox(height: 10),
        Divider(
          thickness: 2,
          color: primary,
        ),
      ],
    );
  }
}
