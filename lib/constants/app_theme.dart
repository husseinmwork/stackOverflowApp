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
import 'package:flutter/services.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/constants/font_family.dart';

TextTheme textTheme = TextTheme(
  headline1: TextStyle(fontSize: 48, fontWeight: FontWeight.w600),
  headline2: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
  headline3: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
  headline4: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
  headline5: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
  headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
  subtitle1: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
  subtitle2: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
  button: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  bodyText1: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  bodyText2: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
  caption: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
  overline: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.5,
      color: Color(0xFF3A3D46)),
);

final ThemeData themeData = new ThemeData(
  textTheme: textTheme,
  fontFamily: FontFamily.productSans,
  brightness: Brightness.light,
  buttonColor: AppColors.shapeColor,
  accentColor: Colors.grey.shade900,
  primaryColor: Colors.green,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary:  Colors.grey.shade900,
      elevation: 0,
    ),
  ),

/*  appBarTheme: AppBarTheme(
    color: Colors.blue[800],
    backwardsCompatibility: false,
    iconTheme: IconThemeData(color: Colors.white),
    systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue[900]),
  ),*/
);

final ThemeData themeDataDark = ThemeData(
  appBarTheme: AppBarTheme(
    color: Colors.grey[800],
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black),
  ),
  textTheme: textTheme,

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.zero,
      primary: Colors.grey[800],
      elevation: 0,
    ),
  ),

  primarySwatch: Colors.grey,
  primaryColor: Colors.grey[800],
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.amber.shade700,
  accentIconTheme: IconThemeData(color: Colors.black),
).copyWith(
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
    },
  ),
);
