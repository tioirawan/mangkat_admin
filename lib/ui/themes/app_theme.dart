import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static ThemeData theme([Brightness brightness = Brightness.light]) {
    var baseTheme = ThemeData(
      brightness: brightness,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF1779D3),
      ),
      // textfield
    );

    final inputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: baseTheme.colorScheme.onBackground.withOpacity(0.1),
      ),
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: inputBorder,
        disabledBorder: inputBorder,
        border: inputBorder,
        focusedBorder: inputBorder.copyWith(
          borderSide: BorderSide(
            color: baseTheme.colorScheme.primary,
          ),
        ),
      ),
    );
  }

  static BoxDecoration get windowCardDecoration {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: const [
        BoxShadow(
          color: Color(0x16000000),
          blurRadius: 23,
          offset: Offset(0, 4),
          spreadRadius: 3,
        ),
      ],
    );
  }
}
