import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryAccent = Color(0xFF40C4FF);
  static const Color cardBackground = Color(0xFFF0F4F8);
  static const Color primaryBackground = Color(0xFFFFFFFF);
  static const Color shadowLight = Color(0xFFFFFFFF);       // For neumorphic light shadow
  static const Color shadowDark = Color(0xFFA8A9AB);        // For neumorphic dark shadow (derived from primaryBackground)

  static const Color textPrimary = Color(0xFF3A4F66);       // A deep, muted blue-grey for main text
  static const Color textSecondary = Color(0xFF788A9B);     // A softer blue-grey for secondary text
  static const Color textOnAccent = Color(0xFFFFFFFF);      // White text on accent color elements

  static const Color iconColor = Color(0xFF788A9B);         // For general icons
  static const Color selectedIconColor = AppColors.primaryAccent; // For selected/active icons

  static const Color error = Color(0xFFD32F2F);           // Standard error red
  static const Color success = Color(0xFF388E3C);          // Standard success green
  static const Color disabledColor = Color(0xFFBDBDBD);     // Grey for disabled elements
}

