import 'package:get/route_manager.dart';
import 'package:househunt/screens/flat_screen.dart';
import 'package:househunt/screens/login_screen.dart';
import 'package:househunt/screens/pg_screen.dart';
import 'package:househunt/screens/sign_up_page.dart';
import 'package:househunt/screens/tenant_profile_screen.dart';
import 'package:househunt/Screens/contact_screen.dart';

final routes = [
  GetPage(name: '/', page: () => SignUp()),
  GetPage(name: '/login', page: () => const LoginScreen()),
  GetPage(name: '/add-pg', page: () => PgHome()),
  GetPage(name: '/add-flat', page: () => FlatHome()),
  GetPage(name: '/tenant-profile', page: () => const TenantProfile()),
  GetPage(name: '/contact-screen', page: () => const ContactUs()),
];
