import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color backgroundColor = Color(0xFF0A1628);
  static const Color accentColor = Color(0xFF378ADD);
  static const Color surfaceColor = Color(0xFF112240);
  static const Color buttonColor = Color(0xFF1A3A5C);
  static const Color operatorColor = Color(0xFF378ADD);
  static const Color equalsColor = Color(0xFF378ADD);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color subTextColor = Color(0xFF8892B0);
  static const Color errorColor = Color(0xFFFF6B6B);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme.dark(
        primary: accentColor,
        surface: surfaceColor,
        error: errorColor,
      ),
      textTheme: GoogleFonts.spaceGroteskTextTheme(
        ThemeData.dark().textTheme,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}