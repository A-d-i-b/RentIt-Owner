import 'package:get/route_manager.dart';
import 'package:househunt/screens/flat_screen.dart';
import 'package:househunt/screens/otp_screen.dart';
import 'package:househunt/screens/pg_screen.dart';
import 'package:househunt/screens/sign_up_page.dart';
import 'package:househunt/screens/tenant_profile_screen.dart';
import 'package:househunt/Screens/contact_screen.dart';
import 'package:househunt/Screens/home_screen.dart';
import 'package:househunt/Screens/owner_update_screen.dart';
import 'Screens/sign_in_page.dart';

final routes = [
  GetPage(name: '/', page: () => SignIn()),
  GetPage(name: '/otp', page: () => OTPScreen()),
  GetPage(name: '/sign-up', page: () => SignUp()),
  GetPage(name: '/update', page: () => OwnerUpdate()),
  GetPage(name: '/home', page: () => const HomeScreen()),
  GetPage(name: '/add-pg', page: () => PgHome()),
  GetPage(name: '/add-flat', page: () => FlatHome()),
  GetPage(name: '/tenant-profile', page: () => const TenantProfile()),
  GetPage(name: '/contact-screen', page: () => const ContactUs()),
];
