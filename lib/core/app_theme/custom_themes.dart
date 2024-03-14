import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../assets_path/fonts_path.dart';
import 'app_colors.dart';

class CustomThemes {

  static TextStyle primaryColorTextTheme(context) =>
      Theme.of(context).textTheme.headlineSmall!;

  static TextStyle secondaryColorTextTheme(context) =>
      Theme.of(context).textTheme.headlineLarge!;

  static TextStyle whiteColoTextTheme(context) =>
      Theme.of(context).textTheme.headlineMedium!;

  static TextStyle greyColor7DTextTheme(context) =>
      Theme.of(context).textTheme.bodyMedium!;

  static TextStyle greyColor71TextTheme(context) =>
      Theme.of(context).textTheme.bodySmall!;

  static TextStyle greyColorD9TextTheme(context) =>
      Theme.of(context).textTheme.bodyLarge!;

  static TextStyle greyColorB0TextTheme(context) =>
      Theme.of(context).textTheme.titleLarge!;

  static TextStyle greenTextTheme(context) =>
      Theme.of(context).textTheme.labelSmall!;
}
