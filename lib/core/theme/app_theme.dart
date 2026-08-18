import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const green = Color(0xFF2E7D32);
  static const lightGreen = Color(0xFFE8F5E9);
  static const beige = Color(0xFFF7F3E8);
  static const darkBackground = Color(0xFF102014);

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: green,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAF7),
        textTheme: GoogleFonts.interTextTheme(),
        cardTheme: CardTheme(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: green, width: 1.4),
          ),
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: green,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: darkBackground,
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        cardTheme: CardTheme(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
      );
}
