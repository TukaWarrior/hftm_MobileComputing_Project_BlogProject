import 'package:blog_project/screens/sensors/sensor_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:blog_project/screens/blog/blog_new_page.dart';
import 'package:blog_project/screens/home_page.dart';
import 'package:blog_project/screens/blogpost/blogpost_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const BlogNewPage(),
    const SensorMetadataScreen(),
    const BlogPostPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[selectedIndex], // Display the selected page
        bottomNavigationBar: Container(
          height: 64.0,
          margin: EdgeInsets.all(24.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: NavigationBar(
              destinations: const [
                NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(
                      Icons.home_outlined,
                      color: Colors.white,
                    ),
                    label: 'Home'),
                // Put this theming in themes folder!
                NavigationDestination(icon: Icon(Icons.category_outlined), label: 'BlogView'),
                NavigationDestination(icon: Icon(Icons.explore_outlined), label: 'CreateBlog'),
                NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'SensorData'),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              backgroundColor: Colors.grey.withOpacity(0.25),
              elevation: 0.0,
              // labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              animationDuration: const Duration(milliseconds: 500),
            ),
          ),
        ),
      ),
    );
  }
}
