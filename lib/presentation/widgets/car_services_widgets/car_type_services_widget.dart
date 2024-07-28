import 'package:car_wash/core/app_theme/app_colors.dart';
import 'package:car_wash/data/models/car_types_model/car_types_model.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../shared_widgets/cached_network_image_widget.dart';

class CarTypeService extends StatelessWidget {
  final ContentImageModel? contentImageModel;

  const CarTypeService({super.key, this.contentImageModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 32.w,
        vertical: 14.h,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.08),
        border: Border.all(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          CachedNetworkImageWidget(
            imagePath: contentImageModel?.image ?? "",
            height: 40.h,
            width: 40.w,
          ),
          const CustomSizedBox(
            width: 16,
          ),
          Text(
            contentImageModel?.name ?? "",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: CustomFontWeights.bold,
            ),
          ),
          const CustomSizedBox(width: 4,),
          Expanded(
            child: Text(
              contentImageModel?.content ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: CustomThemes.primaryColorTextTheme(context).copyWith(
                fontSize: 14.sp,
                fontWeight: CustomFontWeights.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
