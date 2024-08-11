import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../business_logic/orders_cubit/orders_cubit.dart';
import '../../../business_logic/plans_cubit/plans_cubit.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/constants/extensions.dart';
import '../shared_widgets/custom_sized_box.dart';
import 'car_services_check_button.dart';

class MainServicesComponent extends StatefulWidget {
  const MainServicesComponent({super.key});

  @override
  State<MainServicesComponent> createState() => _MainServicesComponentState();
}

class _MainServicesComponentState extends State<MainServicesComponent> {
  @override
  void initState() {
    if (OrdersCubit.get(context).servicesModel == null) {
      OrdersCubit.get(context).getServices();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "الخدمات الرئيسية",
          style: CustomThemes.primaryColorTextTheme(context).copyWith(
            fontSize: 16.sp,
            fontWeight: CustomFontWeights.bold,
          ),
        ),
        const CustomSizedBox(
          height: 16,
        ),
        BlocConsumer<OrdersCubit, OrdersState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = OrdersCubit.get(context);
            return cubit.getServicesLoading
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      return CarServicesCheckButton(
                        isSelected: index == cubit.servicesCurrentIndex,
                        imagePath: cubit.servicesModel!.result![index].image!,
                        price: cubit.servicesModel!.result![index].price.toString(),
                        title: cubit.servicesModel!.result![index].name!,
                        onPressed: () {
                            // PlansCubit.get(context).removeIndex();
                          cubit.changeServicesType(
                            index,
                            cubit.servicesModel!.result![index],
                          );
                        },
                      );
                    },
                    separatorBuilder: (_, index) {
                      return const CustomSizedBox(
                        height: 8,
                      );
                    },
                    itemCount: cubit.servicesModel!.result?.length ?? 0,
                  );
          },
        ),
      ],
    ).symmetricPadding(horizontal: 16);
  }
}
