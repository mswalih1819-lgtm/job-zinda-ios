import 'package:flutter/widgets.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/Pfonts.dart';

class PTextStyles {
  static TextStyle get displayLarge => TextStyle(
        fontFamily: PFonts.inter,
        fontWeight: FontWeight.w700,
        fontSize: 34.0,
      );

  static TextStyle get displayMedium => TextStyle(
        fontFamily: PFonts.inter,
        fontWeight: FontWeight.w500,
        fontSize: 30.0,
      );

  static TextStyle get displaySmall => TextStyle(
        fontFamily: PFonts.inter,
        fontWeight: FontWeight.w500,
        fontSize: 26,
      );

  static TextStyle get headlineLarge => TextStyle(
        fontFamily: PFonts.roboto,
        fontWeight: FontWeight.w500,
        fontSize: 24,
      );

  static TextStyle get headlineMedium => TextStyle(
        fontFamily: PFonts.inter,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );

  static TextStyle get headlineSmall => TextStyle(
        fontFamily: PFonts.inter,
        fontWeight: FontWeight.w300,
        fontSize: 18,
      );

  static TextStyle get titleLarge => TextStyle(
        fontFamily: PFonts.inter,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );

  static TextStyle get titleMedium => TextStyle(
        fontFamily: PFonts.inter,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      );

  static TextStyle get titleSmall => TextStyle(
        fontFamily: PFonts.roboto,
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: PColors.textFeildBorderColor
      );

  static TextStyle get labelLarge => TextStyle(
        fontFamily: PFonts.inter,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      );

  static TextStyle get labelMedium => TextStyle(
        fontFamily: PFonts.inter,
        fontWeight: FontWeight.w400,
        fontSize: 12,
      );

  static TextStyle get labelSmall => TextStyle(
        fontFamily: PFonts.inter,
        fontWeight: FontWeight.w400,
        fontSize: 10,
      );

  static TextStyle get bodyLarge => TextStyle(
        fontFamily: PFonts.manrope,
        fontWeight: FontWeight.w300,
        fontSize: 14,
      );

  static TextStyle get bodyMedium => TextStyle(
        fontFamily: PFonts.manrope,
        fontWeight: FontWeight.w300,
        fontSize: 12,
      );

  static TextStyle get bodySmall => TextStyle(
        fontFamily: PFonts.manrope,
        fontWeight: FontWeight.w300,
        fontSize: 10,
      );
}
