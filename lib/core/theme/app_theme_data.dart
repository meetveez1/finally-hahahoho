import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppThemeData {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.cyan),
    scaffoldBackgroundColor: const Color(0xFFF4F6FA),
    cardColor: Colors.white,
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.midnight,
    cardColor: const Color(0xFF171A22),
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.darkHeader),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.cyan,
      secondary: AppColors.green,
      surface: Color(0xFF171A22),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white),
    ),
    useMaterial3: true,
  );
}
