import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';

class DetailsContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? radius;
  const DetailsContainer({super.key, required this.child, this.padding, this.radius,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding??EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 24.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius?.r??16.r),
        color: AppColors.primaryColor.withOpacity(0.08),
        border: Border.all(
          color: AppColors.primaryColor,
          width: 1.w,
        ),
      ),
      child: child,
    );
  }
}
