import 'package:car_wash/core/app_theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircleContainer extends StatelessWidget {
  final String svgPath;
  final void Function()? onPressed;
  const CircleContainer({
    super.key,
    required this.svgPath, this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 32.h,
      width: 32.w,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: AppColors.greyColorD9,),
      child: InkWell(
        onTap: onPressed,
        customBorder: CircleBorder(),
        child: Center(
          child: SvgPicture.asset(
            svgPath,
            height: 18.h,
            width: 18.w,
          ),
        ),
      ),
    );
  }
}
