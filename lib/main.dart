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
      providers: [createBlogProvider()],
      child: MaterialApp(
        navigatorKey: mainNavigatorKey,
        title: "Interaction and State",
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
