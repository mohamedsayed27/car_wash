import 'package:car_wash/core/app_theme/custom_font_weights.dart';
import 'package:car_wash/core/app_theme/custom_themes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final List<Widget>? actions;
  const CustomAppBar({super.key, required this.title, this.backgroundColor, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      actions: actions,
      backgroundColor: backgroundColor,
      elevation: 0,
      title: Text(
        title.tr(),
        style: CustomThemes.primaryColorTextTheme(context).copyWith(
          fontSize: 18.sp,
          fontWeight: CustomFontWeights.bold,
        ),
      ),
    );
  }
}
