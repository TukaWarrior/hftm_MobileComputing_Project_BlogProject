/// This file sets the theme across the application.
import 'package:flutter/material.dart';

final ThemeData theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent),
  scaffoldBackgroundColor: const ColorScheme.light().surfaceContainerHighest,
  appBarTheme: AppBarTheme(
    backgroundColor: const ColorScheme.light().surfaceContainerHighest,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 30,
    ),
  ),
);
