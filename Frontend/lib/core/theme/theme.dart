import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF7974DB), // Lavender/Purple (matches splash and buttons)
      onPrimary: Color(0xFFFFFFFF), // White text/icons on purple
      secondary: Color(0xFFFFFFFF), // White (backgrounds, cards)
      onSecondary: Color(0xFF9E9E9E), 
      surface: Color(0xFFFFFFFF), // Light lavender (background)
      onSurface: Color(0xFF222222), // Dark text on light bg
      error: Color(0xFFB3261E),
      onError: Color(0xFFFFFFFF),
    ),
    scaffoldBackgroundColor: const Color(0xFFF6F4FB), // Matches background
  );

  static final darkTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF7974DB), // Same purple for dark
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFF232136), // Dark card/background
      onSecondary: Color(0xFF9E9E9E), 
      surface: Color(0xFF18162B), // Very dark background
      onSurface: Color(0xFFF6F4FB), // Light text on dark bg
      error: Color(0xFFB3261E),
      onError: Color(0xFFFFFFFF),
    ),
    scaffoldBackgroundColor: const Color(0xFF18162B),
  );
}