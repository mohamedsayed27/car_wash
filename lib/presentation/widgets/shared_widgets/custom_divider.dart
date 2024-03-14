import 'package:car_wash/core/app_theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDivider extends StatelessWidget {
  final Color? color;
  final double width;

  const CustomDivider({
    super.key,
    this.color ,
    this.width = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: width.w,
      color: color??AppColors.greyColor7D,
    );
  }
}
