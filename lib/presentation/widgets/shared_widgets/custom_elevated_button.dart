import 'package:car_wash/core/app_theme/custom_font_weights.dart';
import 'package:car_wash/core/app_theme/custom_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final double? width;
  final double? height;
  final double? elevation;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final void Function()? onPressed;
  final Widget? child;
  final String? text;
  final TextStyle? titleStyle;

  const CustomElevatedButton({
    super.key,
    this.width,
    this.height,
    this.backgroundColor,
    this.foregroundColor,
    this.onPressed,
    this.child,
    this.text,
    this.borderRadius,
    this.titleStyle,
    this.elevation,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height?.h,
      width: width?.w,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: foregroundColor??AppColors.whiteColor,
          disabledBackgroundColor: AppColors.greyColorD9,
          backgroundColor: backgroundColor??AppColors.primaryColor,
          elevation: elevation??0,
          padding: padding,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius?.r??8.r),
          ),
        ),
        child: child ??
            Text(
              text ?? "",
              style: titleStyle ??
                  CustomThemes.whiteColoTextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: CustomFontWeights.bold,
                      ),
            ),
      ),
    );
  }
}
