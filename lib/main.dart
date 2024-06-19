import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_project/providers/blog_provider.dart';
import 'package:blog_project/screens/main_screen.dart';

void main() {
  runApp(const MainApp());
}

final GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.cyanAccent,
    );
    return ChangeNotifierProvider(
      create: (_) => BlogProvider(),
      child: MaterialApp(
        navigatorKey: mainNavigatorKey,
        title: "Interaction and State",
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: colorScheme,
          scaffoldBackgroundColor: colorScheme.surfaceContainerHighest,
          appBarTheme: AppBarTheme(
            backgroundColor: colorScheme.surfaceContainerHighest,
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
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
