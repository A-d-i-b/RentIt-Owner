import 'package:get/route_manager.dart';
import 'package:househunt/screens/flat_screen.dart';
import 'package:househunt/screens/home_screen.dart';
import 'package:househunt/screens/pg_screen.dart';

final routes = [
  GetPage(name: '/', page: () => const HomeScreen()),
  GetPage(name: '/add-pg', page: () => const PgHome()),
  GetPage(name: '/add-flat', page: () => const FlatHome()),
];
