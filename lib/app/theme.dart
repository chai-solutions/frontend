import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primary = Color(0xFF148FC5);
const Color secondary = Color(0xABABABAB);
const Color tertiary = Color(0xFFC1839F);
const Color error = Color(0xFFAB0807);

const Color lightText = Color(0xFFFFFFFF);
const Color darkText = Color(0xFF3A405A);

const Color background = Color(0xFF242424);
const Color secondaryBackground = Color(0xFF424242);

class GlobalThemeData {
  static ThemeData defaultTheme = themeData(darkColorScheme);

  static ThemeData themeData(ColorScheme colorScheme) {
    final baseTheme = ThemeData(
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

    final defaultTextTheme = baseTheme.textTheme;

    return baseTheme.copyWith(
      textTheme: GoogleFonts.ibmPlexSansTextTheme(defaultTextTheme).copyWith(
        headlineLarge:
            GoogleFonts.cairo(textStyle: defaultTextTheme.headlineLarge),
        headlineMedium:
            GoogleFonts.cairo(textStyle: defaultTextTheme.headlineMedium),
        headlineSmall:
            GoogleFonts.cairo(textStyle: defaultTextTheme.headlineSmall),
        titleLarge: GoogleFonts.cairo(textStyle: defaultTextTheme.titleLarge),
        titleMedium: GoogleFonts.cairo(textStyle: defaultTextTheme.titleMedium),
        titleSmall: GoogleFonts.cairo(textStyle: defaultTextTheme.titleSmall),
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
