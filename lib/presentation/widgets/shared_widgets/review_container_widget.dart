import '../../../core/constants/extensions.dart';
import '../../../presentation/widgets/shared_widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../data/models/review_model/review_model.dart';
import 'custom_sized_box.dart';

class RatingContainerWidget extends StatelessWidget {
  final ReviewModel? reviewModel;

  const RatingContainerWidget({
    super.key,
    required this.reviewModel,
  });

  @override
  Widget build(BuildContext context) {
    var format = DateFormat.yMMMEd();
    return Container(
      width: double.infinity,
      height: 146.h,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xffFAFAFA),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40.h,
                  width: 40.w,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: CachedNetworkImageWidget(
                    imagePath: reviewModel?.client?.avatar ?? "",
                  ),
                ),
                const CustomSizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reviewModel?.client?.name ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            CustomThemes.greyColor71TextTheme(context).copyWith(
                          fontSize: 16.sp,
                          fontWeight: CustomFontWeights.bold,
                        ),
                      ),
                      const CustomSizedBox(
                        height: 8,
                      ),
                      Text(
                        format.format(DateTime.parse(
                            reviewModel?.rateAt.toString() ?? "")),
                        style:
                            CustomThemes.greyColorB0TextTheme(context).copyWith(
                          fontSize: 14.sp,
                          fontWeight: CustomFontWeights.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                RatingBar.builder(
                  initialRating: reviewModel?.rate?.toDouble() ?? 0.0,
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
                  },
                ),
                const CustomSizedBox(
                  width: 14,
                ),
                Text(
                  "(${reviewModel?.rate?.toDouble()})",
                  style: CustomThemes.greyColor71TextTheme(context).copyWith(
                    fontSize: 16.sp,
                    fontWeight: CustomFontWeights.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              reviewModel?.review ?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: CustomThemes.greyColor71TextTheme(context)
                  .copyWith(fontSize: 16.sp, height: 1.49.h),
            ),
          ),
        ],
      ),
    ).onlyDirectionalPadding(end: 10);
  }
}
