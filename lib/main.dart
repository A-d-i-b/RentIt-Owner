import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:househunt/screens/home_screen.dart';
import 'package:househunt/theme/base_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: theme,
      home: const HomeScreen(),
    );
  }
}
