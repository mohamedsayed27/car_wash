
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../shared_widgets/custom_sized_box.dart';

class CustomDrawerButton extends StatelessWidget {
  final String iconPath;
  final String title;
  final void Function()? onPressed;

  const CustomDrawerButton(
      {super.key, required this.iconPath, required this.title, this.onPressed,});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      splashColor: AppColors.primaryColor,
      selectedColor: AppColors.primaryColor,
      style: ListTileStyle.drawer,
      title: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            height: 26.h,
            width: 26.w,
          ),
          const CustomSizedBox(
            width: 16,
          ),
          Text(
            title,
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}