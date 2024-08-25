import 'package:blog_project/providers/blogpost_provider.dart';
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
      ],
      child: MaterialApp(
        navigatorKey: mainNavigatorKey,
        title: "Lucas Blog App",
        theme: theme,
        home: const MainScreen(),
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:blog_project/view/home_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Blog Project',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const HomePage(title: 'Flutter Blog Home Page'),
//     );
//   }
// }
