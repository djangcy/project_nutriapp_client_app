import 'package:flutter/material.dart';

class PrimaryColorScheme {
  static ColorScheme dark = const ColorScheme(
    brightness: Brightness.dark,
    primary: Color.fromARGB(255, 244, 241, 241),
    onPrimary: Color.fromARGB(255, 186, 186, 186),
    primaryContainer: Color.fromARGB(255, 197, 197, 197),
    onPrimaryContainer: Color.fromRGBO(236, 239, 240, 1),
    secondary: Color.fromARGB(255, 201, 201, 201),
    onSecondary: Color.fromARGB(255, 161, 161, 161),
    secondaryContainer: Color.fromARGB(255, 201, 201, 201),
    onSecondaryContainer: Color.fromARGB(255, 74, 74, 74),
    tertiary: Color.fromARGB(255, 51, 51, 51),
    onTertiary: Color.fromARGB(255, 201, 201, 201),
    tertiaryContainer: Color.fromARGB(255, 165, 165, 165),
    onTertiaryContainer: Color.fromARGB(255, 201, 201, 201),
    error: Color.fromARGB(255, 197, 65, 50),
    errorContainer: Color.fromARGB(255, 254, 250, 251),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color.fromARGB(255, 42, 42, 42),
    onBackground: Color.fromARGB(255, 211, 218, 220),
    surface: Color.fromARGB(255, 33, 33, 33),
    onSurface: Color.fromARGB(255, 218, 226, 228),
    surfaceVariant: Color(0xFF3F484A),
    onSurfaceVariant: Color(0xFFBFC8CA),
    outline: Color(0xFF899294),
    onInverseSurface: Color.fromARGB(255, 64, 64, 64),
    inverseSurface: Color.fromARGB(255, 169, 169, 169),
    inversePrimary: Color.fromARGB(255, 53, 53, 53),
    shadow: Color.fromARGB(255, 31, 31, 31),
    surfaceTint: Color.fromARGB(255, 236, 239, 239),
    outlineVariant: Color(0xFF3F484A),
    scrim: Color.fromARGB(255, 27, 27, 27),
  );

  static ColorScheme light = const ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromARGB(255, 244, 241, 241),
    onPrimary: Color.fromARGB(255, 74, 74, 74),
    primaryContainer: Color.fromARGB(255, 211, 211, 211),
    onPrimaryContainer: Color.fromARGB(255, 42, 42, 42),
    secondary: Color.fromARGB(255, 201, 201, 201),
    onSecondary: Color.fromARGB(255, 33, 33, 33),
    secondaryContainer: Color.fromARGB(255, 201, 201, 201),
    onSecondaryContainer: Color.fromARGB(255, 218, 226, 228),
    tertiary: Color.fromARGB(255, 51, 51, 51),
    onTertiary: Color.fromARGB(255, 211, 211, 211),
    tertiaryContainer: Color.fromARGB(255, 184, 184, 184),
    onTertiaryContainer: Color.fromARGB(255, 211, 211, 211),
    error: Color.fromARGB(255, 197, 65, 50),
    errorContainer: Color.fromARGB(255, 254, 250, 251),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color.fromARGB(255, 255, 255, 255),
    onBackground: Color.fromARGB(255, 42, 42, 42),
    surface: Color.fromARGB(255, 240, 240, 240),
    onSurface: Color.fromARGB(255, 50, 50, 50),
    surfaceVariant: Color(0xFFF2F2F2),
    onSurfaceVariant: Color(0xFF2B2B2B),
    outline: Color(0xFF899294),
    onInverseSurface: Color.fromARGB(255, 211, 211, 211),
    inverseSurface: Color.fromARGB(255, 84, 84, 84),
    inversePrimary: Color.fromARGB(255, 202, 202, 202),
    shadow: Color.fromARGB(255, 228, 228, 228),
    surfaceTint: Color.fromARGB(255, 42, 42, 42),
    outlineVariant: Color(0xFFF2F2F2),
    scrim: Color.fromARGB(255, 243, 243, 243),
  );
}