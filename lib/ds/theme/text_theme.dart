import 'package:flutter/material.dart';

class TTextTheme {
  static TextTheme get light => const TextTheme(
        headlineSmall: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 22,
          height: 28 / 22,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.0,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 18,
          height: 24 / 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.0,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 14,
          height: 20 / 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.0,
        ),
        labelLarge: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 12,
          height: 16 / 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
      );
}