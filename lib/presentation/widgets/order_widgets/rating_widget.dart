import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';

class RatingWidget extends StatelessWidget {
  final String title;
  const RatingWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: AppColors.greyColorB0,
          width: 0.5.w,
        ),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: CustomFontWeights.bold,
            ),
          ),
          Expanded(
            child: Center(
              child: RatingBar.builder(
                itemCount: 5,
                itemBuilder: (_, index) {
                  return const Icon(
                    Icons.star,
                  );
                },
                initialRating: 0,
                itemSize: 20.r,
                unratedColor: AppColors.greyColorD9,
                onRatingUpdate: (onRatingUpdate) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
