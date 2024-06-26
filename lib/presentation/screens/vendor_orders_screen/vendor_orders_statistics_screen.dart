import 'package:car_wash/core/constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../business_logic/representative_cubit/representative_cubit.dart';
import '../../../core/app_router/screens_name.dart';
import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/assets_path/svg_path.dart';
import '../../../core/constants/constants.dart';
import '../../widgets/shared_widgets/custom_app_bar.dart';
import '../../widgets/shared_widgets/custom_sized_box.dart';
import '../../widgets/shared_widgets/review_container_widget.dart';
import 'vendor_orders_screen.dart';

class VendorOrdersStatisticsScreen extends StatefulWidget {
  const VendorOrdersStatisticsScreen({super.key});

  @override
  State<VendorOrdersStatisticsScreen> createState() =>
      _VendorOrdersStatisticsScreenState();
}

class _VendorOrdersStatisticsScreenState
    extends State<VendorOrdersStatisticsScreen> {
  @override
  void initState() {
    RepresentativeCubit.get(context)
      ..getAllOrder()
      ..getFinishedOrder()
      ..getOrderReviews()
      ..getNextOrder()
    ..getCurrentOrder();
    super.initState();
  }

  var format = DateFormat.MMMEd('ar');
  var format1 = DateFormat.jm('ar');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "طلباتى",
        ),
      ),
      body: BlocConsumer<RepresentativeCubit, RepresentativeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          RepresentativeCubit cubit = RepresentativeCubit.get(context);
          return ListView(
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
              cubit.getNextOrderLoading
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Container(
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
                              "الطلب المقبل يوم ${cubit.nextOrder}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: CustomThemes.primaryColorTextTheme(context)
                                  .copyWith(
                                fontSize: 16.sp,
                                fontWeight: CustomFontWeights.w500,
                              ),
                            ),
                          ),
                          cubit.nextOrder!=""?TextButton(
                            onPressed: () {
                              RepresentativeCubit.get(context).getSingleOrder(id: RepresentativeCubit.get(context).getNextOrdersModel?.result?.id?.toString()??"0");
                              Navigator.pushNamed(
                                context,
                                ScreenName.vendorProgressOrderScreen,
                              );
                            },
                            style:
                                TextButton.styleFrom(padding: EdgeInsets.zero),
                            child: Text(
                              "اضغط هنا",
                              style: CustomThemes.primaryColorTextTheme(context)
                                  .copyWith(
                                fontSize: 14.sp,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryColor,
                                fontWeight: CustomFontWeights.w500,
                              ),
                            ),
                          ):Text(
                            "لا يوجد بعد",
                            style: CustomThemes.primaryColorTextTheme(context)
                                .copyWith(
                              fontSize: 14.sp,
                              fontWeight: CustomFontWeights.w500,
                            ),
                          ).symmetricPadding(
                            vertical: 8
                          ),
                        ],
                      ),
                    ),
              const CustomSizedBox(
                height: 16,
              ),
              cubit.getCurrentOrderLoading?const Center(child: CircularProgressIndicator.adaptive(),):Container(
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
                        "طلب جارى يوم ${cubit.currentOrder}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: CustomThemes.primaryColorTextTheme(context)
                            .copyWith(
                          fontSize: 16.sp,
                          fontWeight: CustomFontWeights.w500,
                        ),
                      ),
                    ),
                    cubit.currentOrder!=""?TextButton(
                      onPressed: () {
                        RepresentativeCubit.get(context).getSingleOrder(id: RepresentativeCubit.get(context).getCurrentOrderModel?.result?.id?.toString()??"0");
                        Navigator.pushNamed(
                          context,
                          ScreenName.vendorProgressOrderScreen,
                        );
                      },
                      style:
                      TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        "اضغط هنا",
                        style: CustomThemes.primaryColorTextTheme(context)
                            .copyWith(
                          fontSize: 14.sp,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryColor,
                          fontWeight: CustomFontWeights.w500,
                        ),
                      ),
                    ):Text(
                      "لا يوجد بعد",
                      style: CustomThemes.primaryColorTextTheme(context)
                          .copyWith(
                        fontSize: 14.sp,
                        fontWeight: CustomFontWeights.w500,
                      ),
                    ).symmetricPadding(
                        vertical: 8
                    ),
                  ],
                ),
              ),
              const CustomSizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: cubit.getAllOrdersLoading
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : OrdersDetailsContainer(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                ScreenName.vendorOrdersScreen,
                                arguments: VendorOrdersScreenArgs(
                                  orderList:
                                      cubit.getAllOrdersModel?.result ?? [],
                                  title: "كل الطلبات",
                                ),
                              );
                            },
                            numberTextStyle:
                                CustomThemes.primaryColorTextTheme(context)
                                    .copyWith(
                              fontSize: 32.sp,
                              fontWeight: CustomFontWeights.w600,
                            ),
                            borderColor: AppColors.primaryColor,
                            title: "كل الطلبات",
                            number: cubit.getAllOrdersModel?.result?.length
                                    .toString() ??
                                "0",
                          ),
                  ),
                  const CustomSizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: cubit.getFinishedOrdersLoading
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : OrdersDetailsContainer(

                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ScreenName.vendorOrdersScreen,
                          arguments: VendorOrdersScreenArgs(
                            orderList:
                            cubit.getFinishedOrdersModel?.result ?? [],
                            title: "الطلبات الناجحة",
                          ),
                        );
                      },
                            numberTextStyle:
                                CustomThemes.greenTextTheme(context).copyWith(
                              fontSize: 32.sp,
                              fontWeight: CustomFontWeights.w600,
                            ),
                            borderColor: AppColors.greenColor,
                            title: "الطلبات الناجحة",
                            number: cubit.getFinishedOrdersModel?.result?.length
                                    .toString() ??
                                "0",
                          ),
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
              cubit.getAllOrderReviewsLoading
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Container(
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
                            "${cubit.getAllOrderReviewsModel?.result?.total?.count} عميل",
                            style: CustomThemes.primaryColorTextTheme(context)
                                .copyWith(
                              fontSize: 16.sp,
                              fontWeight: CustomFontWeights.w500,
                            ),
                          ),
                          const CustomSizedBox(
                            width: 8,
                          ),
                          Text(
                            "(${cubit.getAllOrderReviewsModel?.result?.total?.rate})",
                            style: CustomThemes.greyColor71TextTheme(context)
                                .copyWith(
                              fontSize: 16.sp,
                              fontWeight: CustomFontWeights.w500,
                            ),
                          ),
                          const Spacer(),
                          RatingBar.builder(
                            initialRating: cubit.getAllOrderReviewsModel?.result
                                    ?.total?.rate
                                    ?.toDouble() ??
                                0.0,
                            minRating: 1,
                            unratedColor: AppColors.greyColorD9,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 24.r,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
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
                  borderRadius: BorderRadius.circular(
                    8.r,
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4.h),
                      blurRadius: 16.r,
                      color: const Color(0xff8E8E8E).withOpacity(0.15),
                    )
                  ],
                ),
                child: cubit.getAllOrderReviewsLoading
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          return RatingContainerWidget(
                            reviewModel: cubit.getAllOrderReviewsModel?.result
                                ?.reviews?[index],
                          );
                        },
                        separatorBuilder: (_, index) {
                          return const CustomSizedBox(
                            height: 12,
                          );
                        },
                        itemCount: cubit.getAllOrderReviewsModel?.result
                                ?.reviews?.length ??
                            0,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class OrdersDetailsContainer extends StatelessWidget {
  final TextStyle numberTextStyle;
  final Color borderColor;
  final String title;
  final String number;
  final void Function()? onTap;

  const OrdersDetailsContainer({
    super.key,
    required this.numberTextStyle,
    required this.borderColor,
    required this.title,
    required this.number,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Ink(
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
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: numberTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
