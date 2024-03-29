import 'package:car_wash/core/app_router/screens_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/assets_path/svg_path.dart';
import '../../../core/constants/constants.dart';
import '../../widgets/shared_widgets/custom_app_bar.dart';
import '../../widgets/shared_widgets/custom_sized_box.dart';
import '../../widgets/shared_widgets/review_container_widget.dart';

class VendorOrdersScreen extends StatelessWidget {
  const VendorOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "طلباتى",
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
        children: [
          Text(
            "الطلبات",
            style: CustomThemes.greyColor71TextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: CustomFontWeights.w600,
            ),
          ),
          const CustomSizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "طلب جارى يوم الاحد 30/6",
                    style: CustomThemes.primaryColorTextTheme(context).copyWith(
                      fontSize: 16.sp,
                      fontWeight: CustomFontWeights.w500,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ScreenName.vendorProgressOrderScreen);
                  },
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    "اضغط هنا",
                    style: CustomThemes.primaryColorTextTheme(context).copyWith(
                      fontSize: 14.sp,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primaryColor,
                      fontWeight: CustomFontWeights.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
          const CustomSizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OrdersDetailsContainer(
                numberTextStyle:
                    CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 32.sp,
                  fontWeight: CustomFontWeights.w600,
                ),
                borderColor: AppColors.primaryColor,
                title: "كل الطلبات",
                number: "150",
              ),
              OrdersDetailsContainer(
                numberTextStyle: CustomThemes.greenTextTheme(context).copyWith(
                  fontSize: 32.sp,
                  fontWeight: CustomFontWeights.w600,
                ),
                borderColor: AppColors.greenColor,
                title: "الطلبات الناجحة",
                number: "100",
              ),
            ],
          ),
          const CustomSizedBox(
            height: 24,
          ),
          Text(
            "التقيمات",
            style: CustomThemes.greyColor71TextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: CustomFontWeights.w600,
            ),
          ),
          const CustomSizedBox(
            height: 16,
          ),
          Container(
            height: 72.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4.h),
                  blurRadius: 16.r,
                  color: const Color(0xff8E8E8E).withOpacity(0.15),
                )
              ],
            ),
            child: Row(
              children: [
                Text(
                  "122 عميل",
                  style: CustomThemes.primaryColorTextTheme(context).copyWith(
                    fontSize: 16.sp,
                    fontWeight: CustomFontWeights.w500,
                  ),
                ),
                const CustomSizedBox(
                  width: 8,
                ),
                Text(
                  "(4.2)",
                  style: CustomThemes.greyColor71TextTheme(context).copyWith(
                    fontSize: 16.sp,
                    fontWeight: CustomFontWeights.w500,
                  ),
                ),
                const Spacer(),
                RatingBar.builder(
                  initialRating: 5,
                  minRating: 1,
                  unratedColor: AppColors.greyColorD9,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 16.r,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, index) => SvgPicture.asset(
                    SvgPath.star,
                  ),
                  onRatingUpdate: (rating) {},
                )
              ],
            ),
          ),
          const CustomSizedBox(
            height: 24,
          ),
          Text(
            "التقيمات",
            style: CustomThemes.greyColor71TextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: CustomFontWeights.w600,
            ),
          ),
          const CustomSizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 24.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4.h),
                  blurRadius: 16.r,
                  color: const Color(0xff8E8E8E).withOpacity(0.15),
                )
              ],
            ),
            child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return const RatingContainerWidget(
                      rating: 4.0,
                      comment:
                          "لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل  ");
                },
                separatorBuilder: (_, index) {
                  return const CustomSizedBox(
                    height: 12,
                  );
                },
                itemCount: 6),
          ),
        ],
      ),
    );
  }
}

class OrdersDetailsContainer extends StatelessWidget {
  final TextStyle numberTextStyle;
  final Color borderColor;
  final String title;
  final String number;

  const OrdersDetailsContainer({
    super.key,
    required this.numberTextStyle,
    required this.borderColor,
    required this.title,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: CustomThemes.greyColor71TextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: CustomFontWeights.w600,
            ),
          ),
          const CustomSizedBox(
            height: 16,
          ),
          Text(
            "$number طلب",
            style: numberTextStyle,
          ),
        ],
      ),
    );
  }
}
