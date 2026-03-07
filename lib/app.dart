import 'package:flutter/material.dart';

import 'core/navigation/app_scroll_behavior.dart';
import 'core/theme/app_theme_data.dart';
import 'features/home/presentation/pages/home_shell.dart';

class SchoolApp extends StatefulWidget {
  const SchoolApp({super.key});

  @override
  State<SchoolApp> createState() => _SchoolAppState();
}

class _SchoolAppState extends State<SchoolApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _setThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Школьное приложение',
      themeMode: _themeMode,
      theme: AppThemeData.lightTheme,
      darkTheme: AppThemeData.darkTheme,
      scrollBehavior: const AppScrollBehavior(),
      home: HomeShell(
        themeMode: _themeMode,
        onThemeChanged: _setThemeMode,
      ),
    );
  }
}
