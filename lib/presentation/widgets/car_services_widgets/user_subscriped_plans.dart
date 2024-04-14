import 'package:car_wash/business_logic/plans_cubit/plans_cubit.dart';
import 'package:car_wash/core/constants/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_router/screens_name.dart';
import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/assets_path/svg_path.dart';
import '../shared_widgets/custom_sized_box.dart';
import '../shared_widgets/custom_text_button.dart';
import 'car_services_check_button.dart';

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
    if (PlansCubit.get(context).userSubscribedPlansList.isEmpty) {
      PlansCubit.get(context).getAllPlans();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            CustomTextButton(
              title: "اشتراك",
              onPressed: () {
                Navigator.pushNamed(context, ScreenName.plansScreen);
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
        BlocConsumer<PlansCubit, PlansState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = PlansCubit.get(context);
            return cubit.getUserPlansLoading
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : cubit.userSubscribedPlansList.isNotEmpty
                    ? ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          return CarServicesCheckButton(
                            isSelected: index == cubit.userPlansCurrentIndex,
                            imagePath: SvgPath.washingMachine,
                            isSvg: true,
                            title: cubit.userSubscribedPlansList[index].name ?? "",
                            price: cubit.userSubscribedPlansList[index].price.toString(),
                            onPressed: () {
                              cubit.changeServicesType(
                                  index, cubit.userSubscribedPlansList[index]);
                            },
                          );
                        },
                        separatorBuilder: (_, index) {
                          return const CustomSizedBox(
                            height: 8,
                          );
                        },
                        itemCount: cubit.userSubscribedPlansList.length,
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
                      );
          },
        ),
      ],
    ).symmetricPadding(horizontal: 16);
  }
}
