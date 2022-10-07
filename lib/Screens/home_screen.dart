import 'package:flutter/material.dart';
import 'package:househunt/Screens/tenant_list_screen.dart';

import 'package:househunt/screens/landing_home_screen.dart';

import 'package:househunt/theme/base_theme.dart';

import 'package:househunt/Screens/tenant_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0, keepPage: false);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
              color: primary,
            ),
          ),
          elevation: 5,
          indicatorColor: Colors.white,
          backgroundColor: Colors.white,
        ),
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: index,
          onDestinationSelected: (value) {
            setState(() {
              index = value;
            });
            pageController.jumpToPage(index);
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home, color: Colors.grey),
              label: "Home",
              selectedIcon: Icon(Icons.home, color: primary),
            ),
            NavigationDestination(
                icon: Icon(Icons.apartment, color: Colors.grey),
                label: "Tenant",
                selectedIcon: Icon(Icons.apartment, color: primary)),
            NavigationDestination(
              icon: Icon(Icons.person, color: Colors.grey),
              label: "Profile",
              selectedIcon: Icon(Icons.person, color: primary),
            ),
          ],
        ),
      ),
      body: PageView(
        controller: pageController,
        children: const [
          LandingHomeScreen(),
          // FlatHome(),
          TenantList(),
          TenantProfile(),
          // PgHome()
        ],
        onPageChanged: (page) {
          setState(() {
            index = page;
          });
        },
      ),
    );
  }
}
