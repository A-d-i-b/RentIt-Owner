import 'package:flutter/material.dart';
import 'package:househunt/screens/landing_home_screen.dart';
import 'package:househunt/screens/owner_profile_screen.dart';
import 'package:househunt/screens/tenant_list_screen.dart';
import 'package:househunt/theme/base_theme.dart';
import 'package:househunt/widgets/bottom_bar_icon.dart';

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
            BottomBarIcon(
              icon: Icons.home,
              color: primary,
              labelName: "Home",
            ),
            BottomBarIcon(
              icon: Icons.apartment,
              color: primary,
              labelName: "Tenant",
            ),
            BottomBarIcon(
              icon: Icons.person,
              color: primary,
              labelName: "Profile",
            ),
          ],
        ),
      ),
      body: PageView(
        controller: pageController,
        children: [
          LandingHomeScreen(),

          const TenantList(),

          OwnerProfile()
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
