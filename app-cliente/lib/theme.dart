import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xFF0066FF);
  static const Color secondaryGreen = Color(0xFF10B981);
  static const Color emergencyRed = Color(0xFFFF0000);
  static const Color bgLight = Color(0xFFF8FAFC);
  static const Color surfaceWhite = Colors.white;
  static const Color textDark = Color(0xFF1E293B);
  static const Color textGray = Color(0xFF64748B);
  static const Color accentYellow = Color(0xFFFACC15);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: bgLight,
      colorScheme: const ColorScheme.light(
        primary: primaryBlue,
        secondary: secondaryGreen,
        surface: surfaceWhite,
        error: emergencyRed,
        onPrimary: Colors.white,
      ),
      textTheme: GoogleFonts.outfitTextTheme().copyWith(
        displayLarge: GoogleFonts.outfit(color: textDark, fontWeight: FontWeight.bold),
        headlineMedium: GoogleFonts.outfit(color: textDark, fontWeight: FontWeight.w600),
        bodyLarge: GoogleFonts.inter(color: textDark),
        bodyMedium: GoogleFonts.inter(color: textGray),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
        hintStyle: GoogleFonts.inter(color: textGray, fontSize: 14),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textDark),
      ),
    );
  }
}
