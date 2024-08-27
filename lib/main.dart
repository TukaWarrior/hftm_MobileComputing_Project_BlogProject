import 'package:blog_project/providers/blogpost_provider.dart';
import 'package:blog_project/providers/theme_provider.dart';
import 'package:blog_project/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:blog_project/providers/blog_provider.dart';
import 'package:blog_project/screens/main_screen.dart';
import 'package:blog_project/settings/theme.dart';

void main() {
  // Set the status bar to be transparent
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Make the status bar transparent
      statusBarIconBrightness: Brightness.light, // Adjust icon brightness for light background
    ),
  );

  runApp(const MainApp());
}

final GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BlogProvider()),
        ChangeNotifierProvider(create: (_) => BlogPostProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()), // Add ThemeProvider here
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            routes: appRoutes,
            // navigatorKey: mainNavigatorKey,
            title: "Lucas Blog App",
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeProvider.themeMode, // Use the theme mode from the provider
            // home: const MainScreen(),
          );
        },
      ),
    );
  }
}
