import 'package:flutter/material.dart';

class AppColors {
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  static const primaryColor = Color(0xff152F4E);
  static const secondaryColor = Color(0xffF6B551);
  static const whiteColor = Color(0xffFFFFFF);
  static const greyColorFA = Color(0xffFAFAFA);
  static const greenColor = Color(0xff0F8205);
  static const blackColor = Color(0xff000000);
  static const splashBackgroundColor = Color(0xff143850);
  static const greyColor7D = Color(0xff7D7D7D);
  static const greyColor71 = Color(0xff717171);
  static const greyColorD9 = Color(0xffD9D9D9);
  static const redColor = Color(0xffFF0000);
  static const greyColorB0 = Color(0xffB0B0B0);
  static const greyColor22 = Color(0xff222222);
  static Color shadowColor({double value = 0.15}) => const Color(0xff000000).withOpacity(value);
}