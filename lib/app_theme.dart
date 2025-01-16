import 'package:flutter/material.dart';

import 'core/constants/color.dart';

class AppTheme {
  static mainTheme() => ThemeData.light(
        useMaterial3: false,
      ).copyWith(
        primaryColor: primaryColor,
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          secondary: secondaryColor,
          onSecondary: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(secondaryColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
        ),
      );

  static welcomeTxt() => const TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      );
}
