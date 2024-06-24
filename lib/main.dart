import 'package:blog_project/providers/theme_provider.dart';
import 'package:blog_project/utils/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_project/screens/main_screen.dart';
import 'package:blog_project/settings/theme.dart';

void main() {
  runApp(const MainApp());
}

final GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [createBlogProvider(), createThemeProvider()],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            navigatorKey: mainNavigatorKey,
            title: "Lucas Blog",
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeProvider.themeMode,
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}




// void main() {
//   runApp(const MainApp());
// }

// final GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [createBlogProvider()],
      
//       child: MaterialApp(
//         navigatorKey: mainNavigatorKey,
//         title: "Lucas Blog",
//         theme: theme,
//         home: const MainScreen(),
//       ),
//     );
//   }
// }
