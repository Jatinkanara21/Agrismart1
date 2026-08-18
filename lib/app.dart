import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'screens/splash/splash_screen.dart';

class AgriSmartApp extends StatefulWidget {
  const AgriSmartApp({super.key});
  @override
  State<AgriSmartApp> createState() => _AgriSmartAppState();
}

class _AgriSmartAppState extends State<AgriSmartApp> {
  ThemeMode mode = ThemeMode.light;

  void toggleTheme() => setState(() {
        mode = mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgriSmart',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: mode,
      home: SplashScreen(onThemeToggle: toggleTheme),
    );
  }
}
