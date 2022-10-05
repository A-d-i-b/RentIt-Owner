import 'package:flutter/material.dart';

class BottomBarIcon extends StatelessWidget {
  const BottomBarIcon({
    Key? key,
    required this.icon,
    required this.color,
  }) : super(key: key);

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: Icon(
        icon,
        color: color,
      ),
      label: "Home",
      selectedIcon: Icon(
        icon,
        color: color,
      ),
    );
  }
}
