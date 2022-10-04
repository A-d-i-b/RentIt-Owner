import 'package:flutter/material.dart';
import 'package:househunt/Screens/example.dart';
import 'package:househunt/Screens/pg.dart';

class Bottomnavbar extends StatefulWidget {
  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
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
              const TextStyle(color: Color(0xFF0EB7B7))),
          elevation: 5,
          indicatorColor: Colors.white,
          backgroundColor: Colors.white,
        ),
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: index,
          onDestinationSelected: (value) {
            setState(() {
              this.index = value;
            });
            pageController.jumpToPage(index);
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.home,
                color: Color(0xFF0EB7B7),
              ),
              label: "Home",
              selectedIcon: Icon(
                Icons.home,
                color: Color(0xFF0EB7B7),
              ),
            ),
            NavigationDestination(
              icon: Icon(
                Icons.apartment,
                color: Color(0xFF0EB7B7),
              ),
              label: "Tenant",
              selectedIcon: Icon(
                Icons.apartment,
                color: Color(0xFF0EB7B7),
              ),
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person,
                color: Color(0xFF0EB7B7),
              ),
              label: "Profile",
              selectedIcon: Icon(
                Icons.person,
                color: Color(0xFF0EB7B7),
              ),
            ),
          ],
        ),
      ),
      body: PageView(
        controller: pageController,
        children: [
          Pghome(),
          Example(),
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
