import 'package:flutter/material.dart';

class BottomBarIcon extends StatelessWidget {
  const BottomBarIcon({
    Key? key,
    required this.icon,
    required this.color,
    required this.lableName,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final String lableName;

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: Icon(
        icon,
        color: Colors.grey,
      ),
      label: lableName,
      selectedIcon: Icon(
        icon,
        color: color,
      ),
    );
  }
}
