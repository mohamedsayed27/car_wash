import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash/core/assets_path/images_path.dart';
import 'package:car_wash/core/constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import 'custom_sized_box.dart';

class RatingContainerWidget extends StatelessWidget {
  final double rating;
  final String comment;

  const RatingContainerWidget({
    super.key,
    required this.rating,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xffFAFAFA),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 40.h,
                width: 40.w,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Image.asset(
                  ImagesPath.dummyPersonImage,
                  fit: BoxFit.cover,
                ),
              ),
              const CustomSizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "احمد خالد",
                    style: CustomThemes.greyColor71TextTheme(context).copyWith(
                      fontSize: 16.sp,
                      fontWeight: CustomFontWeights.bold,
                    ),
                  ),
                  const CustomSizedBox(
                    height: 8,
                  ),
                  Text(
                    "18-11-2022",
                    style: CustomThemes.greyColorB0TextTheme(context).copyWith(
                      fontSize: 14.sp,
                      fontWeight: CustomFontWeights.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                ignoreGestures: true,
                itemCount: 5,
                itemSize: 18.r,
                itemPadding: EdgeInsets.zero,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: AppColors.secondaryColor,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              const CustomSizedBox(
                width: 14,
              ),
              Text(
                "($rating)",
                style: CustomThemes.greyColor71TextTheme(context).copyWith(
                  fontSize: 16.sp,
                  fontWeight: CustomFontWeights.w500,
                ),
              ),
            ],
          ),
          const CustomSizedBox(
            height: 7,
          ),
          Text(
            comment,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: CustomThemes.greyColor71TextTheme(context)
                .copyWith(fontSize: 16.sp, height: 1.49.h),
          ),
          const CustomSizedBox(
            height: 5,
          ),
        ],
      ),
    ).onlyDirectionalPadding(end: 10);
  }
}
