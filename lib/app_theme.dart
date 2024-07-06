import 'package:flutter/material.dart';

class AppTheme {
  static Color mainColor = Colors.deepPurple;

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppTheme.mainColor,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppTheme.mainColor,
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(borderSide: BorderSide()),
    ),
  );
}
