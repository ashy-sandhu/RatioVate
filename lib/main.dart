import 'package:flutter/material.dart';
import 'package:ratiovate/app_theme.dart';
import 'package:ratiovate/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ratiovate BMI Calculator',
      theme: AppTheme.lightTheme, // Applying the custom theme
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // Initial route remains SplashScreen
    );
  }
}

