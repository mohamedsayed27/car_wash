import 'package:car_wash/business_logic/plans_cubit/plans_cubit.dart';
import 'package:car_wash/core/constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:car_wash/presentation/widgets/shared_widgets/custom_check_box.dart';
import '../../../business_logic/orders_cubit/orders_cubit.dart';
import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/assets_path/svg_path.dart';
import '../../../core/constants/constants.dart';
import '../shared_widgets/custom_outlined_button.dart';
import '../shared_widgets/custom_sized_box.dart';
import '../shared_widgets/custom_text_button.dart';

class MonthlySubscriptionsComponent extends StatefulWidget {
  const MonthlySubscriptionsComponent({super.key});

  @override
  State<MonthlySubscriptionsComponent> createState() =>
      _MonthlySubscriptionsComponentState();
}

class _MonthlySubscriptionsComponentState
    extends State<MonthlySubscriptionsComponent> {
  @override
  void initState() {
    if (PlansCubit.get(context).plansList.isEmpty) {
      PlansCubit.get(context).getAllPlans();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlansCubit, PlansState>(
      listener: (context, state) {
        if (state is SubscribePlanLoadingState) {
          showProgressIndicator(context);
        } else if (state is SubscribePlanSuccessState) {
          Navigator.pop(context);
          PlansCubit.get(context).getAllPlans();
        } else if (state is SubscribePlanErrorState) {
          Navigator.pop(context);
          showToast(
            errorType: 0,
            message: state.error,
          );
        }
      },
      builder: (context, state) {
        var cubit = PlansCubit.get(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "الاشتراكات الشهرية",
                    textAlign: TextAlign.start,
                    style: CustomThemes.primaryColorTextTheme(context).copyWith(
                      fontSize: 16.sp,
                      fontWeight: CustomFontWeights.bold,
                    ),
                  ),
                ),
                if (!cubit.plansList.any((e) => e.isSubscribed == 1))
                  CustomTextButton(
                    title: "اشتراك",
                    onPressed: () {
                      cubit.subscribePlan(
                        planId: cubit.userPlansModel!.id.toString(),
                      );
                    },
                    style: CustomThemes.primaryColorTextTheme(context).copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primaryColor,
                    ),
                  ),
              ],
            ),
            const CustomSizedBox(
              height: 16,
            ),
            cubit.getUserPlansLoading
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : cubit.plansList.isNotEmpty
                    ? ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          return !cubit.plansList
                                  .any((e) => e.isSubscribed == 1)
                              ? CarServicesCheckButton(
                                  isSelected:
                                      index == cubit.userPlansCurrentIndex,
                                  imagePath: SvgPath.washingMachine,
                                  isSvg: true,
                                  washNumber: cubit.plansList[index].washNumber
                                      .toString(),
                                  title: cubit.plansList[index].name ?? "",
                                  price:
                                      cubit.plansList[index].price.toString(),
                                  onPressed: () {
                                    // OrdersCubit.get(context).removeIndex();
                                    cubit.changePlan(
                                      index,
                                      cubit.plansList[index],
                                    );
                                  },
                                  isChecked:
                                      index == cubit.userPlansCurrentIndex,
                                )
                              : CarServicesCheckButton(
                                  isSelected:
                                      cubit.plansList[index].isSubscribed == 1,
                                  imagePath: SvgPath.washingMachine,
                                  isSvg: true,
                                  washNumber: cubit.plansList[index].washNumber
                                      .toString(),
                                  title: cubit.plansList[index].name ?? "",
                                  price:
                                      cubit.plansList[index].price.toString(),
                                  onPressed:
                                      cubit.plansList[index].isSubscribed == 1
                                          ? () {
                                              // if (OrdersCubit.get(context)
                                              //         .servicesCurrentIndex !=
                                              //     null) {
                                                // OrdersCubit.get(context)
                                                //     .removeIndex();
                                              // }
                                              cubit.changePlan(index,
                                                  cubit.plansList[index]);
                                            }
                                          : null,
                                  isChecked:
                                      index == cubit.userPlansCurrentIndex,
                                );
                        },
                        separatorBuilder: (_, index) {
                          return const CustomSizedBox(
                            height: 8,
                          );
                        },
                        itemCount: cubit.plansList.length,
                      )
                    : Center(
                        child: Text(
                          "لم يتم الاشتارك في اي باقة",
                          textAlign: TextAlign.center,
                          style: CustomThemes.greyColor71TextTheme(context)
                              .copyWith(
                            fontSize: 14.sp,
                            fontWeight: CustomFontWeights.w500,
                          ),
                        ),
                      )
          ],
        );
      },
    ).symmetricPadding(horizontal: 16);
  }
}

class CarServicesCheckButton extends StatelessWidget {
  final bool isSelected;
  final bool isChecked;
  final void Function()? onPressed;
  final String imagePath;
  final String title;
  final bool isSvg;
  final String? price;
  final String? washNumber;

  const CarServicesCheckButton({
    super.key,
    required this.isSelected,
    this.onPressed,
    required this.imagePath,
    required this.title,
    this.price,
    this.isSvg = false,
    this.washNumber,
    required this.isChecked,
  });

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      borderColor: isSelected ? AppColors.primaryColor : AppColors.greyColorB0,
      borderRadius: 8,
      onPressed: onPressed,
      backgroundColor: isSelected
          ? AppColors.primaryColor.withOpacity(0.08)
          : AppColors.whiteColor,
      foregroundColor: AppColors.primaryColor,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                SvgPicture.asset(
                  imagePath,
                  height: 40.h,
                  width: 40.w,
                ),
                const CustomSizedBox(
                  width: 16,
                ),
                Text(
                  title,
                  style: isSelected
                      ? CustomThemes.primaryColorTextTheme(context).copyWith(
                          fontSize: 16.sp,
                          fontWeight: CustomFontWeights.bold,
                        )
                      : CustomThemes.greyColorB0TextTheme(context).copyWith(
                          fontSize: 16.sp,
                          fontWeight: CustomFontWeights.w500,
                        ),
                ),
                const CustomSizedBox(
                  width: 8,
                ),
                Text(
                  "$washNumber غسلات",
                  style: isSelected
                      ? CustomThemes.primaryColorTextTheme(context).copyWith(
                          fontSize: 16.sp,
                          fontWeight: CustomFontWeights.bold,
                        )
                      : CustomThemes.greyColorB0TextTheme(context).copyWith(
                          fontSize: 16.sp,
                          fontWeight: CustomFontWeights.w500,
                        ),
                ),
                const Spacer(),
                Text(
                  "$price",
                  style: isSelected
                      ? CustomThemes.primaryColorTextTheme(context).copyWith(
                          fontSize: 16.sp,
                          fontWeight: CustomFontWeights.w500,
                        )
                      : CustomThemes.greyColorB0TextTheme(context).copyWith(
                          fontSize: 16.sp,
                          fontWeight: CustomFontWeights.w500,
                        ),
                ),
              ],
            ),
          ),
          const CustomSizedBox(
            width: 8,
          ),
          CustomCheckBox(
            isChecked: isChecked,
          ),
        ],
      ),
    );
  }
}
