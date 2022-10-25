import 'package:get/get.dart';
import 'package:househunt/screens/flat_screen.dart';
import 'package:househunt/screens/otp_screen.dart';
import 'package:househunt/screens/pg_screen.dart';
import 'package:househunt/screens/sign_in_page.dart';
import 'package:househunt/screens/sign_up_page.dart';
import 'package:househunt/screens/splash_screen.dart';
import 'package:househunt/screens/tenant_profile_screen.dart';
import 'package:househunt/Screens/contact_screen.dart';
import 'package:househunt/Screens/home_screen.dart';
import 'package:househunt/Screens/owner_update_screen.dart';
import 'package:househunt/Screens/example.dart';

final routes = [
  GetPage(
    name: '/',
    page: () => const SplashScreen(),
  ),
  GetPage(name: '/sign-in', page: () => SignIn()),
  GetPage(name: '/otp', page: () => OTPScreen()),
  GetPage(name: '/sign-up', page: () => SignUp()),
  GetPage(name: '/update', page: () => const OwnerUpdate()),
  GetPage(
    name: '/home',
    page: () => const HomeScreen(),
  ),
  GetPage(name: '/add-pg', page: () => PgHome()),
  GetPage(name: '/add-flat', page: () => FlatHome()),
  GetPage(name: '/tenant-profile', page: () => const TenantProfile()),
  GetPage(name: '/contact-screen', page: () => const ContactUs()),
  GetPage(name: '/example', page: () => Example()),
];
