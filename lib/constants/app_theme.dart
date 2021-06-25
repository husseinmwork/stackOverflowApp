// import 'package:boilerplate/constants/colors.dart';
// import 'package:boilerplate/constants/font_family.dart';
/**
 * Creating custom color palettes is part of creating a custom app. The idea is to create
 * your class of custom colors, in this case `CompanyColors` and then create a `ThemeData`
 * object with those colors you just defined.
 *
 * Resource:
 * A good resource would be this website: http://mcg.mbitson.com/
 * You simply need to put in the colour you wish to use, and it will generate all shades
 * for you. Your primary colour will be the `500` value.
 *
 * Colour Creation:
 * In order to create the custom colours you need to create a `Map<int, Color>` object
 * which will have all the shade values. `const Color(0xFF...)` will be how you create
 * the colours. The six character hex code is what follows. If you wanted the colour
 * #114488 or #D39090 as primary colours in your theme, then you would have
 * `const Color(0x114488)` and `const Color(0xD39090)`, respectively.
 *
 * Usage:
 * In order to use this newly created theme or even the colours in it, you would just
 * `import` this file in your project, anywhere you needed it.
 * `import 'path/to/theme.dart';`
 */

import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/constants/font_family.dart';

TextTheme textTheme = TextTheme(
    headline1: TextStyle(
        fontSize: 48, fontWeight: FontWeight.w600, color: Colors.white),
    headline2: TextStyle(
        fontSize: 40, fontWeight: FontWeight.w600, color: Colors.white),
    headline3: TextStyle(
        fontSize: 36, fontWeight: FontWeight.w600, color: Colors.white),
    headline4: TextStyle(
        fontSize: 32, fontWeight: FontWeight.w600, color: Colors.white),
    headline5: TextStyle(
        fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
    headline6: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
    subtitle1: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
    subtitle2: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
    button: TextStyle(
        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
    bodyText1: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
    bodyText2: TextStyle(
        fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white),
    caption: TextStyle(
        fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
    overline: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
        color: Color(0xFF3A3D46)));

final ThemeData themeData = new ThemeData(
    textTheme: textTheme,
    fontFamily: FontFamily.productSans,
    brightness: Brightness.light,
    buttonColor: AppColors.shapeColor,
    cardColor: Colors.white,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          primary: Colors.white, backgroundColor: Colors.blue.shade600),
    ),
    // primarySwatch: MaterialColor(AppColors.orange[500]!.value, AppColors.orange),
    scaffoldBackgroundColor: Colors.white,
    // scaffoldBackgroundColor: Colors.grey,
    primaryColor: Colors.blue,
    backgroundColor: Colors.white,
    primaryColorBrightness: Brightness.light,
    accentColor: Colors.blue,
    accentColorBrightness: Brightness.light,
    primarySwatch: Colors.grey,
    dividerColor: Colors.white54,
    iconTheme: IconThemeData(color: Colors.white));

final ThemeData themeDataDark = ThemeData(
  appBarTheme: AppBarTheme(
    color: AppColors.scaffoldBackgroundColor,
  ),
  textTheme: textTheme,
  fontFamily: FontFamily.productSans,
  brightness: Brightness.dark,
  primaryColor: Colors.purple.shade300,
  // cardColor:Colors.white,

  scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
  primaryColorBrightness: Brightness.dark,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: AppColors.scaffoldBackgroundColor),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
        primary: Colors.white, backgroundColor: Colors.green),
  ),
  accentColor: AppColors.scaffoldBackgroundColor,

  accentColorBrightness: Brightness.dark,
  // iconTheme: IconThemeData(color: Colors.red),
  primarySwatch: Colors.grey,
  // backgroundColor: const Color(0xFF212121),
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
);
