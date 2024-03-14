import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';

class HintContainerWidget extends StatelessWidget {
  const HintContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.primaryColor.withOpacity(0.08),
        border: Border.all(
          color: AppColors.primaryColor,
          width: 1.w,
        ),
      ),
      child: Text(
        "* الإلغاء  أو تغيير الموعد مجاناً قبل 6 ساعات على الأقل من موعد الغسيل",
        style: CustomThemes.primaryColorTextTheme(context).copyWith(
          fontSize: 12.sp,
          fontWeight: CustomFontWeights.w400,
        ),
      ),
    );
  }
}
