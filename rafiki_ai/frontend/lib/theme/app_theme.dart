import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RafikiTheme {
  // Primary color palette
  static const Color primaryColor = Color(0xFF5C2D91); // Purple
  static const Color secondaryColor = Color(0xFF009688); // Teal
  static const Color accentColor = Color(0xFFFFAB40); // Amber accent
  
  // Background colors
  static const Color scaffoldBgColor = Color(0xFFF5F5F5);
  static const Color cardColor = Colors.white;
  
  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Colors.white;
  
  // Chat bubble colors
  static const Color userBubbleColor = Color(0xFFE1F5FE);
  static const Color aiBubbleColor = Color(0xFFE8F5E9);
  
  // Create theme data
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: cardColor,
        error: Colors.red.shade700,
      ),
      scaffoldBackgroundColor: scaffoldBgColor,
      cardColor: cardColor,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: primaryColor,
        iconTheme: IconThemeData(color: textLight),
        titleTextStyle: TextStyle(
          color: textLight,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: GoogleFonts.nunitoTextTheme(
        TextTheme(
          displayLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(color: textPrimary, fontWeight: FontWeight.w700),
          headlineSmall: TextStyle(color: textPrimary, fontWeight: FontWeight.w700),
          titleLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(color: textPrimary, fontWeight: FontWeight.w600),
          titleSmall: TextStyle(color: textPrimary, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(color: textPrimary),
          bodyMedium: TextStyle(color: textPrimary),
          bodySmall: TextStyle(color: textSecondary),
          labelLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.w600),
          labelMedium: TextStyle(color: textPrimary),
          labelSmall: TextStyle(color: textSecondary),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: textLight,
          backgroundColor: primaryColor,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: textLight,
      ),
      iconTheme: IconThemeData(
        color: primaryColor,
      ),
    );
  }
}