import 'package:flutter/material.dart';
import 'package:househunt/theme/base_theme.dart';

class DetailCard extends StatefulWidget {
  DetailCard({Key? key, required this.detail, required this.icon, this.ontap})
      : super(key: key);
  final String detail;
  final IconData icon;
  VoidCallback? ontap;
  @override
  State<DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
      child: Column(
        children: [
          Row(children: [
            Icon(
              widget.icon,
              color: primary,
              size: 20,
            ),
            const SizedBox(width: 30),
            Flexible(
              child: Text(
                widget.detail,
                style: const TextStyle(
                  fontSize: 20,
                  color: secondary,
                ),
              ),
            ),
          ]),
          const SizedBox(height: 10),
          Divider(
            thickness: 2,
            color: primary,
          ),
        ],
      ),
    );
  }
}
