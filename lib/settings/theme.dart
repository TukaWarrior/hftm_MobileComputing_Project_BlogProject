import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent, brightness: Brightness.light),
  scaffoldBackgroundColor: const ColorScheme.light().surfaceContainerHighest,
  fontFamily: "Mulish",
  appBarTheme: AppBarTheme(
    backgroundColor: const ColorScheme.light().surfaceContainerHighest,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 30,
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent, brightness: Brightness.dark),
  scaffoldBackgroundColor: const ColorScheme.dark().surfaceContainerHighest,
  fontFamily: "Mulish",
  appBarTheme: AppBarTheme(
    backgroundColor: const ColorScheme.dark().surfaceContainerHighest,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 30,
    ),
  ),
);


// Original Theme
// final ThemeData theme = ThemeData(
//   useMaterial3: true,
//   colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent),
//   scaffoldBackgroundColor: const ColorScheme.light().surfaceContainerHighest,
//   fontFamily: "Mulish",
//   appBarTheme: AppBarTheme(
//     backgroundColor: const ColorScheme.light().surfaceContainerHighest,
//   ),
//   textTheme: const TextTheme(
//     titleLarge: TextStyle(
//       fontSize: 30,
//     ),
//   ),
// );
