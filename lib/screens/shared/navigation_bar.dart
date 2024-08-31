import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.0,
      margin: const EdgeInsets.all(24.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: NavigationBar(
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.category_outlined), label: 'BlogView'),
            NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'SensorData'),
            NavigationDestination(icon: Icon(Icons.account_box_outlined), label: 'Profile'),
          ],
          selectedIndex: selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              selectedIndex = index;
              // Add navigation logic based on index
              switch (index) {
                case 0:
                  // Navigator.pushNamed(context, '/');
                  break;
                case 1:
                  Navigator.pushNamed(context, '/blognew');
                  break;
                case 2:
                  Navigator.pushNamed(context, '/sensors');
                  break;
                case 3:
                  Navigator.pushNamed(context, '/profile');
                  break;
              }
            });
          },
          indicatorColor: Colors.transparent,
          backgroundColor: Colors.grey.withOpacity(0.25),
          animationDuration: const Duration(milliseconds: 500),
        ),
      ),
    );
  }
}
