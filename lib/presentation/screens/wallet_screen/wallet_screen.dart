import 'package:car_wash/business_logic/orders_cubit/orders_cubit.dart';
import 'package:car_wash/core/constants/extensions.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/details_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../business_logic/plans_cubit/plans_cubit.dart';
import '../../../core/app_router/screens_name.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/constants/constants.dart';
import '../../widgets/choose_car_type_and_location_on_map_widgets/car_type_list.dart';
import '../../widgets/shared_widgets/custom_app_bar.dart';
import '../../widgets/shared_widgets/custom_sized_box.dart';
import '../../widgets/shared_widgets/select_date_component.dart';
import '../../widgets/shared_widgets/select_time_component.dart';
import '../../widgets/shared_widgets/services_type_and_time_widget.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    OrdersCubit.get(context).getAllOrder();
    if (PlansCubit.get(context).plansList.isEmpty) {
      PlansCubit.get(context).getAllPlans();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "المحفظة",
        ),
      ),
      body: ListView(
        children: [
          BlocConsumer<PlansCubit, PlansState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              PlansCubit cubit = PlansCubit.get(context);
              return DetailsContainer(
                radius: 6,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14),
                child: cubit.getUserPlansLoading
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : Text(
                        "انت مشترك في باقة ${PlansCubit.get(context).plansList.firstWhere((element) => element.isSubscribed == 1).name} ولديك عدد ${PlansCubit.get(context).plansList.firstWhere((element) => element.isSubscribed == 1).washNumber} غسلة متبقي ",
                        style: CustomThemes.primaryColorTextTheme(context)
                            .copyWith(
                          fontSize: 16.sp,
                          fontWeight: CustomFontWeights.bold,
                        ),
                      ),
              );
            },
          ).symmetricPadding(horizontal: 16),
          const CustomSizedBox(
            height: 16,
          ),
          ExpansionTile(
            title: Text(
              "الطلبات القادمة",
              style: CustomThemes.primaryColorTextTheme(context).copyWith(
                fontSize: 16.sp,
                fontWeight: CustomFontWeights.bold,
              ),
            ),
            children: [
              const SelectDateComponent(),
              const CustomSizedBox(
                height: 24,
              ),
              const SelectTimeComponent(),
              const CustomSizedBox(
                height: 16,
              ),
              Text(
                "نوع السيارة",
                textAlign: TextAlign.start,
                style: CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 16.sp,
                  fontWeight: CustomFontWeights.bold,
                ),
              ).symmetricPadding(horizontal: 16),
              const CustomSizedBox(
                height: 16,
              ),
              const CarTypeList(
                shrinkWrap: true,
              ).symmetricPadding(horizontal: 16),
              const CustomSizedBox(
                height: 16,
              ),
//                   BlocConsumer<OrdersCubit, OrdersState>(
//   listener: (context, state) {
//     // TODO: implement listener
//   },
//   builder: (context, state) {
//     OrdersCubit cubit = OrdersCubit.get(context);
//     return CustomElevatedButton(
//                 onPressed: () {
//                   cubit.makeOrder(
//                       addOrderParameters: AddOrderParameters(
//                         userPlanId: PlansCubit.get(context)
//                             .plansList
//                             .firstWhere(
//                                 (element) => element.isSubscribed == 1)
//                             .userIdPlan
//                             .toString(),
//                         serviceId: widget.userConfirmOrderArguments.servicesModel?.id
//                             .toString(),
//                         carTypeId: widget.userConfirmOrderArguments
//                             .carServicesArgument?.contentImageModel!.id
//                             .toString(),
//                         userAddressId: widget.userConfirmOrderArguments
//                             .carServicesArgument?.addressModel.id
//                             .toString(),
//                         orderTimeId: widget
//                             .userConfirmOrderArguments.timeModel?.id
//                             .toString(),
//                       )
//                   );
//                 },
//                 width: double.infinity,
//                 text: "حجز",
//                 height: 48,
//               );
//   },
// ).symmetricPadding(horizontal: 16),
              const CustomSizedBox(
                height: 16,
              ),
            ],
          ),
          BlocConsumer<OrdersCubit, OrdersState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              OrdersCubit cubit = OrdersCubit.get(context);
              return ExpansionTile(
                title: Text(
                  "الطلبات السابقة",
                  style: CustomThemes.primaryColorTextTheme(context).copyWith(
                    fontSize: 16.sp,
                    fontWeight: CustomFontWeights.bold,
                  ),
                ),
                children: [
                  cubit.getAllOrdersLoading
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                          separatorBuilder: (_, index) => const CustomSizedBox(
                            height: 16,
                          ),
                          itemBuilder: (_, index) => ServiceTypeAndTimeWidget(
                            singleOrderModel:
                                cubit.getAllOrdersModel?.result?[index],
                            onTap: () {
                              cubit.getSingleOrder(
                                  id: cubit.getAllOrdersModel?.result?[index]
                                          .id ??
                                      0);
                              Navigator.pushNamed(
                                context,
                                ScreenName.userOrderProgressScreen,
                              );
                            },
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              cubit.getAllOrdersModel?.result?.length ?? 0,
                        ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
