import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/assets_path/svg_path.dart';

class CustomDropDownButton<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>>? items;
  final void Function(T?)? onChanged;
  final T? value;
  final String? hintText;
  final Widget? hint;
  final Widget? prefixIcon;
  final TextStyle? style;
  final Color? borderColor;
  const CustomDropDownButton({
    super.key,
    this.items,
    this.onChanged,
    this.value,
    this.hintText, this.hint, this.prefixIcon, this.style, this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(
        color: borderColor??AppColors.greyColorB0,
        width: 1.w,
      ),
    );
    InputBorder focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(
        color: borderColor??AppColors.greyColorB0,
        width: 1.w,
      ),
    );
    InputBorder errorBorderColor = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(
        color: AppColors.redColor,
        width: 1.w,
      ),
    );
    return DropdownButtonFormField(
      items: items,
      onChanged: onChanged,
      value: value,
      isExpanded: false,
      hint: hint,
      style: style,
      padding: EdgeInsets.zero,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        hintStyle: CustomThemes.greyColorB0TextTheme(context).copyWith(fontSize: 12.sp,fontWeight: FontWeight.w500),
        border: border,
        contentPadding: EdgeInsetsDirectional.only(
          start: 12.w,
          end: 4.w,
          bottom: 4.h,
          top: 4.h,
        ),
        focusedBorder: focusedBorder,
        enabledBorder: border,

        disabledBorder: border,
        errorBorder: errorBorderColor,
      ),
      iconSize: 40.r,
      icon: Ink(
        height: 40.h,
        width: 40.w,
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: AppColors.primaryColor,
        ),
        child: SvgPicture.asset(
          SvgPath.arrowDown,
          height: 16.h,
          width: 16.w,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}