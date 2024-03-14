import 'package:car_wash/core/app_theme/app_colors.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/assets_path/svg_path.dart';

class CarTypeService extends StatelessWidget {
  const CarTypeService({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.w,vertical: 14.h,),
      margin: EdgeInsets.symmetric(horizontal: 16.w,),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.08),
        border: Border.all(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            SvgPath.smallCar,
            width: 40.w,
            height: 40.h,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          const CustomSizedBox(width: 16,),
          Text(
            "حجم السيارة",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: CustomFontWeights.bold,
            )
          ),
          const Spacer(),
          Text(
              "حجم صغير",
              style: CustomThemes.primaryColorTextTheme(context).copyWith(
                fontSize: 14.sp,
                fontWeight: CustomFontWeights.w400,
              )
          ),
        ],
      ),
    );
  }
}
