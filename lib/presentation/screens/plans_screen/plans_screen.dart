import 'package:car_wash/core/constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../business_logic/plans_cubit/plans_cubit.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/assets_path/svg_path.dart';
import '../../../core/constants/constants.dart';
import '../../widgets/car_services_widgets/car_services_check_button.dart';
import '../../widgets/shared_widgets/custom_app_bar.dart';
import '../../widgets/shared_widgets/custom_elevated_button.dart';
import '../../widgets/shared_widgets/custom_sized_box.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(title: "الاشتراكات الشهريه"),
      ),
      body: BlocConsumer<PlansCubit, PlansState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit = PlansCubit.get(context);
          return Column(
            children: [
              const CustomSizedBox(height: 32,),
              Expanded(child: cubit.getUserPlansLoading
                  ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
                  : cubit.userNotSubscribedPlansList.isNotEmpty
                  ? ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: (_, index) {
                  return CarServicesCheckButton(
                    isSelected: index == cubit.selectedPlanIndex,
                    imagePath: SvgPath.washingMachine,
                    isSvg: true,
                    title: cubit.userNotSubscribedPlansList[index].name ?? "",
                    price: cubit.userNotSubscribedPlansList[index].price.toString(),
                    onPressed: () {
                      // cubit.selectedSubscribePlanIndex(
                      //     index, cubit.userNotSubscribedPlansList[index]);
                    },
                  );
                },
                separatorBuilder: (_, index) {
                  return const CustomSizedBox(
                    height: 16,
                  );
                },
                itemCount: cubit.userNotSubscribedPlansList.length,
              )
                  : Center(
                child: Text(
                  "لم يتم الاشتارك في اي باقة",
                  textAlign: TextAlign.center,
                  style:
                  CustomThemes.greyColor71TextTheme(context).copyWith(
                    fontSize: 14.sp,
                    fontWeight: CustomFontWeights.w500,
                  ),
                ),
              ),),
              const CustomSizedBox(height: 32,),
              CustomElevatedButton(
                onPressed: () {
                  cubit.subscribePlan(planId: cubit.selectedSubscribePlan!.id.toString());
                },
                width: double.infinity,
                text: "الاشتراك",
                height: 48,
              ),
              const CustomSizedBox(height: 32,),
            ],
          ).symmetricPadding(horizontal: 16);
        },
      ),
    );
  }
}
