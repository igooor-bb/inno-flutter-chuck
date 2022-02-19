import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChuckTheme {
  static TextTheme lightTextTheme = TextTheme(
    bodyText1: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    bodyText1: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  );

  static ThemeData light() {
    return ThemeData(
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
        textTheme: lightTextTheme,
        primaryColor: Colors.pink,
        secondaryHeaderColor: Colors.black26);
  }

  static ThemeData dark() {
    return ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: Colors.grey[900],
        ),
        textTheme: darkTextTheme,
        primaryColor: Colors.orange,
        secondaryHeaderColor: Colors.brown);
  }
}
