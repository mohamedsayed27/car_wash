import 'package:car_wash/core/assets_path/images_path.dart';
import 'package:car_wash/core/assets_path/svg_path.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/cached_network_image_widget.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../data/models/order_models/single_order_model.dart';
import 'circle_container.dart';

class AgentDetailsWidget extends StatelessWidget {
  final Representative? representative;

  const AgentDetailsWidget({super.key, this.representative});

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
          child: CachedNetworkImageWidget(
            imagePath: representative?.avatar ?? "",
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
              representative?.name ?? "",
              style: CustomThemes.primaryColorTextTheme(context).copyWith(
                fontSize: 16.sp,
                fontWeight: CustomFontWeights.bold,
              ),
            ),
            // const CustomSizedBox(
            //   height: 8,
            // ),
            // Row(
            //   children: [
            //     CircleContainer(
            //       svgPath: SvgPath.message,
            //       onPressed: () {},
            //     ),
            //     const CustomSizedBox(
            //       width: 8,
            //     ),
            //     CircleContainer(
            //       svgPath: SvgPath.call,
            //       onPressed: () {},
            //     ),
            //   ],
            // )
          ],
        ),
      ],
    );
  }
}
