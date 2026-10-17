import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Foodi {
  static Color greenColor = const Color(0xffb8e361);
  static Color orangeColor = const Color(0xffd36617);

  static SharedPreferences? sharedPreferences;

  static TextStyle dmSerifDisplayRegular = GoogleFonts.dmSerifDisplay(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  );

  static TextStyle dmSerifDisplayItalic = GoogleFonts.dmSerifDisplay(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
    ),
  );
}
