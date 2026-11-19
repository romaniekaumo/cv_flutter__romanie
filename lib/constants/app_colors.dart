import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Palette principale : Bleu foncé, Blanc, Bleu clair
  static const Color primaryDarkBlue = Color(0xFF0D2B52);
  static const Color primaryBlue = Color(0xFF15437A);
  static const Color lightBlue = Color(0xFF3B82F6);
  static const Color softLightBlue = Color(0xFFEAF2FF);
  static const Color iceBlue = Color(0xFFF4F8FE);

  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color backgroundLight = Color(0xFFF7FAFF);
  static const Color surfaceCard = Color(0xFFFFFFFF);

  static const Color textDark = Color(0xFF0F172A);
  static const Color textMuted = Color(0xFF475569);
  static const Color borderLight = Color(0xFFD6E4F7);
  static const Color errorRed = Color(0xFFB91C1C);

  static ThemeData buildTheme() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryDarkBlue,
      primary: primaryDarkBlue,
      secondary: lightBlue,
      surface: backgroundLight,
      onSurface: textDark,
      error: errorRed,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: backgroundLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryDarkBlue,
        foregroundColor: pureWhite,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: surfaceCard,
        elevation: 1.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: borderLight, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: iceBlue,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryDarkBlue, width: 2),
        ),
      ),
    );
  }
}