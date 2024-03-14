import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/assets_path/images_path.dart';
import '../shared_widgets/custom_sized_box.dart';

class IntroDetailsWidget extends StatelessWidget {
  const IntroDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Row(
        children: [
          Container(
            height: 50.h,
            width: 50.w,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              ImagesPath.dummyPersonImage,
              fit: BoxFit.cover,
            ),
          ),
          const CustomSizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "محمود سالم",
                  style:
                  CustomThemes.primaryColorTextTheme(context).copyWith(
                    fontSize: 16.sp,
                    fontWeight: CustomFontWeights.bold,
                  ),
                ),
                const CustomSizedBox(
                  height: 8,
                ),
                Text(
                  "تعديل الملف الشخصي",
                  style:
                  CustomThemes.greyColorB0TextTheme(context).copyWith(
                    fontSize: 12.sp,
                    fontWeight: CustomFontWeights.w500,
                  ),
                )
              ],
            ),
          )
        ],
      );
  }
}
