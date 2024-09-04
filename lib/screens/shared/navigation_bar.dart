import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Determine the current route and update the selectedIndex once. Unfortunately, the navbar does rebuild every time the route is changed, which causes it to loose the selected index.
    String? currentRoute = ModalRoute.of(context)?.settings.name;
    switch (currentRoute) {
      case '/':
        selectedIndex = 0;
        break;
      case '/blognew':
        selectedIndex = 1;
        break;
      case '/sensors':
        selectedIndex = 2;
        break;
      case '/profile':
        selectedIndex = 3;
        break;
      case '/blogpost':
        selectedIndex = 4;
        break;
      default:
        selectedIndex = 0; // Default to home if route is not found
    }
  }

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
            NavigationDestination(icon: Icon(Icons.account_box_outlined), label: 'BlogPost'),
          ],
          selectedIndex: selectedIndex,
          onDestinationSelected: (int index) {
            // Update the selected index and navigate
            if (selectedIndex != index) {
              setState(() {
                selectedIndex = index;
              });

              // Check if the current route is different from the selected one
              switch (index) {
                case 0:
                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                  break;
                case 1:
                  Navigator.pushNamedAndRemoveUntil(context, '/blognew', (route) => false); // Remove all previous routes
                  break;
                case 2:
                  Navigator.pushNamedAndRemoveUntil(context, '/sensors', (route) => false);
                  break;
                case 3:
                  Navigator.pushNamedAndRemoveUntil(context, '/profile', (route) => false);
                  break;
                case 4:
                  Navigator.pushNamedAndRemoveUntil(context, '/blogpost', (route) => false);
                  break;
                default:
                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              }
            }
          },
          indicatorColor: Colors.transparent,
          backgroundColor: Colors.grey.withOpacity(0.25),
          animationDuration: const Duration(milliseconds: 500),
        ),
      ),
    );
  }
}
