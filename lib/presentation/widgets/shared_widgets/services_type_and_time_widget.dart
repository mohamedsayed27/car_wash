import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import 'custom_divider.dart';
import 'custom_sized_box.dart';
import 'details_container.dart';

class ServiceTypeAndTimeWidget extends StatelessWidget {
  const ServiceTypeAndTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailsContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "الخدمة",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: CustomFontWeights.bold,
            ),
          ),
          const CustomSizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "غسيل داخلي",
                style:
                CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 14.sp,
                  fontWeight: CustomFontWeights.w400,
                ),
              ),
              Text(
                "70 ريال",
                style:
                CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 14.sp,
                  fontWeight: CustomFontWeights.w400,
                ),
              ),
            ],
          ),
          const CustomSizedBox(
            height: 8,
          ),
          const CustomDivider(),
          const CustomSizedBox(
            height: 8,
          ),
          Text(
            "المواعيد",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: CustomFontWeights.bold,
            ),
          ),
          const CustomSizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "الأحد",
                style:
                CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 14.sp,
                  fontWeight: CustomFontWeights.w400,
                ),
              ),
              Text(
                "9:00",
                style:
                CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 14.sp,
                  fontWeight: CustomFontWeights.w400,
                ),
              ),
              Text(
                "3/10/2023",
                style:
                CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 14.sp,
                  fontWeight: CustomFontWeights.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
