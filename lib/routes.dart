import 'package:get/route_manager.dart';
import 'package:househunt/screens/flat_screen.dart';
import 'package:househunt/screens/home_screen.dart';
import 'package:househunt/screens/pg_screen.dart';
import 'package:househunt/screens/tenant_profile_screen.dart';
import 'package:househunt/Screens/contact_screen.dart';

final routes = [
  GetPage(name: '/', page: () => const HomeScreen()),
  GetPage(name: '/add-pg', page: () => const PgHome()),
  GetPage(name: '/add-flat', page: () => const FlatHome()),
  GetPage(name: '/tenant-profile', page: () => TenantProfile()),
  GetPage(name: '/contact-screen', page: () => ContactUs()),
];
