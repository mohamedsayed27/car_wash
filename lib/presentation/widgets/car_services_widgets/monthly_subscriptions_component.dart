import 'package:car_wash/business_logic/plans_cubit/plans_cubit.dart';
import 'package:car_wash/core/constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/assets_path/svg_path.dart';
import '../shared_widgets/custom_sized_box.dart';
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
    if(PlansCubit.get(context).userPlansList.isEmpty){
      PlansCubit.get(context).getAllPlans();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "الاشتراكات الشهرية",
          style: CustomThemes.primaryColorTextTheme(context).copyWith(
            fontSize: 16.sp,
            fontWeight: CustomFontWeights.bold,
          ),
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
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      return CarServicesCheckButton(
                        isSelected: index == cubit.userPlansCurrentIndex,
                        imagePath: SvgPath.washingMachine,
                        isSvg: true,
                        title: cubit.userPlansList[index].name??"",
                        price: cubit.userPlansList[index].price.toString(),
                        onPressed: () {
                          cubit.changeServicesType(index, cubit.userPlansList[index]);
                        },
                      );
                    },
                    separatorBuilder: (_, index) {
                      return const CustomSizedBox(
                        height: 8,
                      );
                    },
                    itemCount: cubit.userPlansList.length,
                  );
          },
        ),
      ],
    ).symmetricPadding(horizontal: 16);
  }
}
