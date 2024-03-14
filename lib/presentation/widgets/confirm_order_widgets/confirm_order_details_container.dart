import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../widgets/shared_widgets/custom_divider.dart';
import '../../widgets/shared_widgets/details_container.dart';

class ConfirmOrderContainer extends StatelessWidget {
  const ConfirmOrderContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailsContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "حجم السيارة",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: CustomFontWeights.bold,
            ),
          ),
          const CustomSizedBox(
            height: 8,
          ),
          Text(
            "حجم صغير",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 14.sp,
              fontWeight: CustomFontWeights.w400,
            ),
          ),
          const CustomSizedBox(
            height: 16,
          ),
          const CustomDivider(),
          const CustomSizedBox(
            height: 16,
          ),
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
                style: CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 14.sp,
                  fontWeight: CustomFontWeights.w400,
                ),
              ),
              Text(
                "70 ريال",
                style: CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 14.sp,
                  fontWeight: CustomFontWeights.w400,
                ),
              ),
            ],
          ),
          const CustomSizedBox(
            height: 16,
          ),
          const CustomDivider(),
          const CustomSizedBox(
            height: 16,
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
                style: CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 14.sp,
                  fontWeight: CustomFontWeights.w400,
                ),
              ),
              Text(
                "9:00",
                style: CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 14.sp,
                  fontWeight: CustomFontWeights.w400,
                ),
              ),
              Text(
                "3/10/2023",
                style: CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 14.sp,
                  fontWeight: CustomFontWeights.w400,
                ),
              ),
            ],
          ),
          const CustomSizedBox(
            height: 16,
          ),
          const CustomDivider(),
          const CustomSizedBox(
            height: 16,
          ),
          Text(
            "الاشتراكات الشهرية",
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
                "5 غسلات بالشهر",
                style: CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 14.sp,
                  fontWeight: CustomFontWeights.w400,
                ),
              ),
              Text(
                "70 ريال",
                style: CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 14.sp,
                  fontWeight: CustomFontWeights.w400,
                ),
              ),
            ],
          ),
          const CustomSizedBox(
            height: 16,
          ),
          const CustomDivider(),
          const CustomSizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "الاجمالي",
                style: CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 16.sp,
                  fontWeight: CustomFontWeights.bold,
                ),
              ),
              Text(
                "140 ريال",
                style: CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 14.sp,
                  fontWeight: CustomFontWeights.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
