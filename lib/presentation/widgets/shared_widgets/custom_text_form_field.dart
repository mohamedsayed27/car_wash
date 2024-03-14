import 'package:car_wash/core/app_theme/custom_font_weights.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_themes.dart';

class CustomTextField extends StatelessWidget {
  final bool enabled;
  final TextEditingController? controller;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? fillColor;
  final bool isNotVisible;
  final bool? filled;
  final FocusNode? focusNode;
  final TextAlignVertical? textAlignVertical;
  final int? maxLines;
  final int? minLines;

  const CustomTextField({
    super.key,
    this.enabled = true,
    this.isNotVisible = false,
    this.controller,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
    this.fillColor,
    this.filled,
    this.textAlignVertical,
    this.maxLines,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.r),
      borderSide: BorderSide(
        color: AppColors.greyColorB0,
        width: 1.w,
      ),
    );
    InputBorder focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.r),
      borderSide: BorderSide(
        color: AppColors.primaryColor,
        width: 1.w,
      ),
    );
    InputBorder errorBorderColor = OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.r),
      borderSide: BorderSide(
        color: AppColors.redColor,
        width: 1.w,
      ),
    );
    return TextFormField(
      controller: controller,
      obscureText: isNotVisible,
      textAlignVertical: textAlignVertical,
      maxLines: maxLines,
      minLines: minLines,
      focusNode: focusNode,
      style: CustomThemes.primaryColorTextTheme(context).copyWith(
        fontSize: 16.sp,
        fontWeight: CustomFontWeights.w500,
      ),

      decoration: InputDecoration(
        border: border,
        focusedBorder: focusedBorder,
        enabledBorder: border,
        disabledBorder: border,
        errorBorder: errorBorderColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: fillColor,
        filled: filled,
        hintText: hintText,
        hintStyle: CustomThemes.greyColorD9TextTheme(context).copyWith(
          fontSize: 16.sp,
          fontWeight: CustomFontWeights.w500,
        ),
        enabled: enabled,
      ),
    );
  }
}
