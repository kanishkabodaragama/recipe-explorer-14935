import 'package:flutter/material.dart';

/// AppTheme centralizes color palette and theming configuration.
class AppTheme {
  AppTheme._();

  static const Color primary = Color(0xFF4CAF50);
  static const Color accent = Color(0xFFFF5722);
  static const Color secondary = Color(0xFFFFC107);

  // PUBLIC_INTERFACE
  /// Returns the light theme using the provided palette and modern minimal style.
  static ThemeData light() {
    final ColorScheme base =
        ColorScheme.fromSeed(seedColor: primary, brightness: Brightness.light);

    final ColorScheme scheme = base.copyWith(
      primary: primary,
      secondary: secondary,
      tertiary: accent,
      surface: Colors.white,
      onSurface: Colors.black,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 1,
        surfaceTintColor: Colors.transparent,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.tertiary,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: const Color(0xFFF7F8FA),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.tertiary,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: scheme.primary,
        unselectedItemColor: Colors.grey.withAlpha(0x99),
        type: BottomNavigationBarType.fixed,
        backgroundColor: scheme.surface,
        elevation: 8,
      ),
      cardTheme: CardTheme(
        elevation: 0,
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
