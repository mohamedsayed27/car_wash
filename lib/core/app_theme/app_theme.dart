import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../assets_path/fonts_path.dart';
import 'app_colors.dart';

class AppTheme{

  static ThemeData lightTheme = ThemeData(
    primarySwatch: AppColors.createMaterialColor(AppColors.primaryColor),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
    primaryColor: AppColors.primaryColor,
    canvasColor: AppColors.whiteColor,
    useMaterial3: true,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.whiteColor,
      elevation: 0
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.whiteColor,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
    ),
    scaffoldBackgroundColor: AppColors.whiteColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        foregroundColor: AppColors.whiteColor,
        elevation: 0,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        foregroundColor: AppColors.whiteColor,
        elevation: 0,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.red,
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontFamily: FontsPath.bahij,
        height: 1,
        color: AppColors.primaryColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: FontsPath.bahij,
        height: 1,
        color: AppColors.whiteColor,
      ),
      headlineLarge: TextStyle(
        fontFamily: FontsPath.bahij,
        height: 1,
        color: AppColors.secondaryColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: FontsPath.bahij,
        height: 1,
        color: AppColors.greyColor7D,
      ),
      bodyLarge: TextStyle(
        fontFamily: FontsPath.bahij,
        height: 1,
        color: AppColors.greyColorD9,
      ),
      bodySmall: TextStyle(
        fontFamily: FontsPath.bahij,
        height: 1,
        color: AppColors.greyColor71,
      ),
      titleLarge: TextStyle(
        fontFamily: FontsPath.bahij,
        height: 1,
        color: AppColors.greyColorB0,
      ),
      labelSmall:TextStyle(
        fontFamily: FontsPath.bahij,
        height: 1,
        color: AppColors.greenColor,
      ),
    ),
  );

}