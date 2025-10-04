import 'package:flutter/material.dart';

class AppTypography {
  // Font Families
  static const String primaryFont = 'Roboto';
  static const String secondaryFont = 'Roboto';

  // Font Sizes
  static const double fontSize10 = 10.0;
  static const double fontSize12 = 12.0;
  static const double fontSize14 = 14.0;
  static const double fontSize16 = 16.0;
  static const double fontSize18 = 18.0;
  static const double fontSize20 = 20.0;
  static const double fontSize24 = 24.0;
  static const double fontSize28 = 28.0;
  static const double fontSize32 = 32.0;
  static const double fontSize36 = 36.0;
  static const double fontSize48 = 48.0;

  // Font Weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;

  // Line Heights
  static const double lineHeightTight = 1.2;
  static const double lineHeightNormal = 1.4;
  static const double lineHeightRelaxed = 1.6;
  static const double lineHeightLoose = 1.8;

  // Text Styles
  static const TextStyle displayLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: fontSize48,
    fontWeight: bold,
    height: lineHeightTight,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: fontSize36,
    fontWeight: bold,
    height: lineHeightTight,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: fontSize32,
    fontWeight: bold,
    height: lineHeightTight,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: fontSize28,
    fontWeight: semiBold,
    height: lineHeightNormal,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: fontSize24,
    fontWeight: semiBold,
    height: lineHeightNormal,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: fontSize20,
    fontWeight: semiBold,
    height: lineHeightNormal,
  );

  static const TextStyle titleLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: fontSize18,
    fontWeight: medium,
    height: lineHeightNormal,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: fontSize16,
    fontWeight: medium,
    height: lineHeightNormal,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: fontSize14,
    fontWeight: medium,
    height: lineHeightNormal,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: fontSize16,
    fontWeight: regular,
    height: lineHeightRelaxed,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: fontSize14,
    fontWeight: regular,
    height: lineHeightRelaxed,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: fontSize12,
    fontWeight: regular,
    height: lineHeightRelaxed,
  );

  static const TextStyle labelLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: fontSize14,
    fontWeight: medium,
    height: lineHeightNormal,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: fontSize12,
    fontWeight: medium,
    height: lineHeightNormal,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: fontSize10,
    fontWeight: medium,
    height: lineHeightNormal,
  );
}
