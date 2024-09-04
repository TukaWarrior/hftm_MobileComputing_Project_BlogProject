import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  // The light mode is not created yet.
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent, brightness: Brightness.light),
  scaffoldBackgroundColor: const ColorScheme.light().surfaceContainerHighest,
  fontFamily: "Mulish",
  appBarTheme: AppBarTheme(
    backgroundColor: const ColorScheme.light().surfaceContainerHighest,
  ),
  // textTheme: const TextTheme(
  //   titleLarge: TextStyle(
  //     fontSize: 30,
  //   ),
  // ),
  // navigationBarTheme: NavigationBarThemeData(
  //   indicatorColor: Colors.transparent, // Transparent indicator for dark theme
  //   backgroundColor: const Color(0xFF32353F), // Darker background for dark theme
  //   labelTextStyle: WidgetStateProperty.all(
  //     const TextStyle(color: Colors.white), // Label color for dark theme
  //   ),
  //   iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((Set<WidgetState> states) {
  //     if (states.contains(WidgetState.selected)) {
  //       return const IconThemeData(color: Colors.cyanAccent); // Icon color when selected
  //     }
  //     return const IconThemeData(color: Colors.white); // Icon color when not selected
  //   }),
  // ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent, brightness: Brightness.dark),
  scaffoldBackgroundColor: const Color(0xFF353645), // Set the background color here
  // scaffoldBackgroundColor: const ColorScheme.dark().surfaceContainerHighest,
  fontFamily: "Mulish",
  appBarTheme: AppBarTheme(
    backgroundColor: const ColorScheme.dark().surfaceContainerHighest,
  ),

  // textTheme: const TextTheme(
  //   displayLarge: TextStyle(
  //     fontWeight: FontWeight.w800,
  //     fontSize: 30,§
  //   ),
  // ),
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: Colors.transparent, // Transparent indicator for dark theme
    backgroundColor: const Color(0xFF30333c), // Darker background for dark theme
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const TextStyle(color: Color.fromARGB(255, 202, 206, 218)); // Text color when selected
      }
      return const TextStyle(color: Color.fromARGB(255, 118, 122, 133)); // Text color when not selected
    }),
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const IconThemeData(color: Colors.grey); // Icon color when selected
      }
      return const IconThemeData(color: Color(0xFF5e6169)); // Icon color when not selected
    }),
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
