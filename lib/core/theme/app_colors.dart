import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // 🎨 Main Theme Colors
  static const Color primary = Color(0xFF0D9488); // Teal
  static const Color secondary = Color(0xFF0F172A); // Navy (Dark)
  static const Color background = Color(0xFFF1F5F9); // Light background
  static const Color card = Color(0xFFFFFFFF); // White
  static const Color textPrimary = Color(0xFF0F172A); // Dark text
  static const Color accent = Color(0xFF38BDF8); // Light Blue

  //  AppBar Gradient
  static const List<Color> appBarGradient = [
    Color(0xFF2563EB), // Blue
    Color(0xFF14B8A6), // Teal
  ];

  //  Primary (Teal) opacity colors
  static const Color primary05 = Color(0x0D0D9488); // 5%
  static const Color primary10 = Color(0x1A0D9488); // 10%
  static const Color primary15 = Color(0x260D9488); // 15%
  static const Color primary20 = Color(0x330D9488); // 20%
  static const Color primary25 = Color(0x400D9488); // 25%

  //  Secondary (Navy) opacity colors
  static const Color secondary05 = Color(0x0D0F172A); // 5%
  static const Color secondary10 = Color(0x1A0F172A); // 10%
  static const Color secondary15 = Color(0x260F172A); // 15%
  static const Color secondary20 = Color(0x330F172A); // 20%

  //  Accent (Light Blue) opacity colors
  static const Color accent10 = Color(0x1A38BDF8); // 10%
  static const Color accent15 = Color(0x2638BDF8); // 15%
  static const Color accent20 = Color(0x3338BDF8); // 20%
}
