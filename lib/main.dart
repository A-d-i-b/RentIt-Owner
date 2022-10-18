import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:househunt/controllers/initial_bindings.dart';
import 'package:househunt/routes.dart';
import 'package:househunt/theme/base_theme.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: Init(),
      debugShowCheckedModeBanner: false,
      theme: theme,
      getPages: routes,
    );
  }
}
