import 'package:car_wash/core/assets_path/images_path.dart';
import 'package:car_wash/core/assets_path/svg_path.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import 'circle_container.dart';

class AgentDetailsWidget extends StatelessWidget {
  const AgentDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 56.h,
          width: 56.w,
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "احمد خالد",
              style: CustomThemes.primaryColorTextTheme(context).copyWith(
                fontSize: 16.sp,
                fontWeight: CustomFontWeights.bold,
              ),
            ),
            CustomSizedBox(height: 8,),
             Row(
              children: [
                CircleContainer(
                  svgPath: SvgPath.message,
                  onPressed: (){},
                ),
                CustomSizedBox(
                  width: 8,
                ),
                CircleContainer(
                  svgPath: SvgPath.call,
                  onPressed: (){},
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
