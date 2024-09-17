import 'package:flutter/material.dart';

const Color primary = Color(0xFFF37125);
const Color secondary = Color(0xFFFED766);
const Color tertiary = Color(0xFFC1839F);
const Color error = Color(0xFF8C001A);

const Color lightText = Color(0xFFE6E6EA);
const Color darkText = Color(0xFF3A405A);

const Color background = Color(0xFF121212);
const Color secondaryBackground = Color(0xFF343434);

class GlobalThemeData {
  static ThemeData defaultTheme = themeData(darkColorScheme);

  static ThemeData themeData(ColorScheme colorScheme) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        foregroundColor: lightText,
        backgroundColor: secondaryBackground,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      colorScheme: colorScheme,
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      cardColor: tertiary,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: secondaryBackground,
        selectedItemColor: primary,
      ),
    );
  }

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: primary,
    secondary: secondary,
    surface: background,
    surfaceBright: secondaryBackground,
    tertiary: tertiary,
    error: error,
    onError: lightText,
    onPrimary: lightText,
    onSecondary: darkText,
    onSurface: lightText,
    brightness: Brightness.dark,
  );
}
