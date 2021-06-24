import 'package:flutter/material.dart';

class AppGradient {
  const AppGradient._();

  // static const scaffoldGradient = LinearGradient(
  //   begin: Alignment.topLeft,
  //   end: Alignment.bottomRight,
  //   stops: [0.11, 0.3 , 0.7],
  //   colors: [
  //     Color(0xFF2f1c53),
  //     Color(0xFF181a20),
  //     Color(0xFF181a20)
  //   ],
  // );

  static const orangeGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    stops: [0.1, 0.7],
    colors: [
      Color(0xFFFFEBA2),
      Color(0xFFFF8669),
    ],
  );

  static const purpleGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    stops: [0.1, 0.7],
    colors: [
      Color(0xFFC393FF),
      Color(0xFFE42A6C),
    ],
  );
}
