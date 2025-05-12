import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryAccent,
      scaffoldBackgroundColor: AppColors.primaryBackground,
      cardColor: AppColors.cardBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor:
            AppColors.primaryBackground, // Keep app bar light and clean
        elevation: 0, // No shadow for a flatter look
        iconTheme: IconThemeData(
            color: AppColors.textPrimary), // Darker icons on light app bar
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontSize: 34.0,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            letterSpacing: -0.5),
        displayMedium: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            letterSpacing: -0.5),
        displaySmall: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            letterSpacing: -0.25),
        headlineMedium: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary),
        headlineSmall: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary),
        titleLarge: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary), // For card titles or section headers
        bodyLarge: TextStyle(
            fontSize: 16.0, color: AppColors.textPrimary, height: 1.5),
        bodyMedium: TextStyle(
            fontSize: 14.0, color: AppColors.textSecondary, height: 1.5),
        labelLarge: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: AppColors.textOnAccent), // For text on buttons
        bodySmall: TextStyle(
            fontSize: 12.0,
            color: AppColors.textSecondary,
            height: 1.4), // For captions or smaller text
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryAccent,
          foregroundColor: AppColors.textOnAccent,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // Softer rounded corners
          ),
          elevation: 2, // Subtle elevation
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryAccent,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cardBackground, // Inputs on card background
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: AppColors.shadowDark.withValues(alpha: 0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: AppColors.shadowDark.withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide:
              const BorderSide(color: AppColors.primaryAccent, width: 2.0),
        ),
        labelStyle:
            const TextStyle(color: AppColors.textSecondary, fontSize: 16),
        hintStyle:
            const TextStyle(color: AppColors.textSecondary, fontSize: 14),
      ),
      cardTheme: CardTheme(
        elevation: 0, // Neumorphic elements will handle their own shadows
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(16.0), // Consistent rounded corners
        ),
        color: AppColors.cardBackground,
        margin: const EdgeInsets.symmetric(
            vertical: 8.0, horizontal: 0), // No horizontal margin by default
      ),
      iconTheme: const IconThemeData(
        color: AppColors.iconColor,
        size: 24.0,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primaryAccent,
        inactiveTrackColor: AppColors.primaryAccent.withValues(alpha: 0.3),
        thumbColor: AppColors.primaryAccent,
        overlayColor: AppColors.primaryAccent.withValues(alpha: 0.2),
        valueIndicatorColor: AppColors.primaryAccent,
        valueIndicatorTextStyle: const TextStyle(color: AppColors.textOnAccent),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: AppColors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        titleTextStyle: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary),
        contentTextStyle: const TextStyle(
            fontSize: 16.0, color: AppColors.textSecondary, height: 1.5),
      ),
    );
  }
}
