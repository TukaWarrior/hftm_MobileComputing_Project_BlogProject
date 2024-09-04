import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blog/services/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_blog/providers/theme_provider.dart';
import 'package:flutter_blog/routes.dart';
import 'package:flutter_blog/settings/theme.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter bindings are initialized
  runApp(const App()); // Run the app with Firebase initialization
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // Future to hold the initialization status of Firebase
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Error initializing Firebase: ${snapshot.error}'),
              ),
            ),
          );
        }

        // Show a loading spinner while Firebase is initializing
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        // Once Firebase is initialized, show the main application
        // Set the status bar to be transparent
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent, // Make the status bar transparent
            statusBarIconBrightness: Brightness.light, // Adjust icon brightness for light background
          ),
        );

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
            ChangeNotifierProvider(create: (_) => ProfileProvider()),
          ],
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return MaterialApp(
                routes: appRoutes,
                title: "Lucas Blog App",
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: themeProvider.themeMode,
              );
            },
          ),
        );
      },
    );
  }
}
