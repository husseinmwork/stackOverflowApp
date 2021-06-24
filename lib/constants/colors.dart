import 'package:flutter/material.dart';

class AppColors {
  const AppColors._(); // this basically makes it so you can't instantiate this class

  static const Map<int, Color> orange = const <int, Color>{
    50: const Color(0xFFFCF2E7),
    100: const Color(0xFFF8DEC3),
    200: const Color(0xFFF3C89C),
    300: const Color(0xFFEEB274),
    400: const Color(0xFFEAA256),
    500: const Color(0xFFE69138),
    600: const Color(0xFFE38932),
    700: const Color(0xFFDF7E2B),
    800: const Color(0xFFDB7424),
    900: const Color(0xFFD56217)
  };

  //all color of dark mode app
  ///this primary
  static const blue = Color(0xFF246BFD);

  ///this secondary
  static const lightPurple = Color(0xFFC25FFF);
  static const DarkPurple = Color(0xFF470073);

  ///this bg1
  static const scaffoldBackgroundColor = Color(0xFF181A20);

  ///this bg2
  static const shapeColor = Color(0xFF262A34);
}
