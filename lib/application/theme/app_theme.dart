import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData appTheme = ThemeData().copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: 52,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      // displaySmall: const TextStyle(
      //   fontFamily: 'PorterSansBlock',
      //   fontSize: 36,
      //   fontWeight: FontWeight.w400,
      //   color: kOrangePeel,
      // ),
      // headlineMedium: const TextStyle(
      //   fontFamily: 'PorterSansBlock',
      //   fontSize: 32,
      //   fontWeight: FontWeight.w400,
      //   color: kOrangePeel,
      // ),
      headlineSmall: GoogleFonts.inter(
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      bodyMedium: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      // labelLarge: GoogleFonts.ribeye(
      //   fontSize: 14,
      //   color: Colors.white,
      // ),
      labelMedium: GoogleFonts.poppins(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      // labelSmall: GoogleFonts.ribeye(
      //   letterSpacing: 0.0,
      // ),
    ),
  );
}
