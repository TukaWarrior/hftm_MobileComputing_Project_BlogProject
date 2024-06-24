import 'package:blog_project/main.dart';
import 'package:flutter/material.dart';
import 'package:blog_project/screens/blog/blog_new_page.dart';
import 'package:blog_project/screens/home_page.dart';

class MainMenuItem {
  static final List<MainMenuItem> items = _getMenuItems();

  final IconData icon;
  final String text;
  final Widget page;
  final GlobalKey<NavigatorState> navigatorKey;

  MainMenuItem({required this.icon, required this.text, required this.page}) : navigatorKey = GlobalKey<NavigatorState>();
}

List<MainMenuItem> _getMenuItems() => [
      MainMenuItem(icon: Icons.article, text: "Blogs", page: const HomePage()),
      MainMenuItem(icon: Icons.add, text: "New Blog", page: const BlogNewPage()),
    ];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final selectedMenuItem = MainMenuItem.items[selectedIndex];

    // The container for the current page, with its background color
    // and subtle switching animation.
    var mainArea = ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: PopScope(
          // PopScope is not running onPopInvoked on Android Gesture
          // https://github.com/flutter/flutter/issues/138624
          canPop: true,
          onPopInvoked: (_) => () async {
            if (!await selectedMenuItem.navigatorKey.currentState!.maybePop()) {
              mainNavigatorKey.currentState!.pop();
            }
          },
          child: Navigator(
            key: selectedMenuItem.navigatorKey,
            onGenerateRoute: (settings) => MaterialPageRoute(builder: (context) => selectedMenuItem.page),
          ),
        ),
      ),
    );

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 450) {
            // Use a more mobile-friendly layout with BottomNavigationBar
            // on narrow screens.
            // Using of upper Scaffold necessary to avoid
            // Issues with BottomNavigationBar Space over Keyboard
            return Scaffold(
              body: mainArea,
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: true,
                items: MainMenuItem.items
                    .map((m) => BottomNavigationBarItem(
                          icon: Icon(m.icon),
                          label: m.text,
                        ))
                    .toList(),
                currentIndex: selectedIndex,
                onTap: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            );
          } else {
            return Row(
              children: [
                NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: MainMenuItem.items.map((m) => NavigationRailDestination(icon: Icon(m.icon), label: Text(m.text))).toList(),
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
                Expanded(child: mainArea),
              ],
            );
          }
        },
      ),
    );
  }
}
