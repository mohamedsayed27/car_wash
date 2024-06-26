import 'package:car_wash/core/enums/order_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../business_logic/orders_cubit/orders_cubit.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/constants/constants.dart';
import '../../widgets/order_widgets/first_index_component.dart';
import '../../widgets/order_widgets/orders_nav_bar_widget.dart';
import '../../widgets/order_widgets/second_index_component.dart';
import '../../widgets/order_widgets/stepper_widget.dart';
import '../../widgets/order_widgets/third_index_component.dart';
import '../../widgets/shared_widgets/custom_app_bar.dart';
import '../../widgets/shared_widgets/custom_sized_box.dart';

class UserOrderProgressScreen extends StatefulWidget {
  const UserOrderProgressScreen({super.key});

  @override
  State<UserOrderProgressScreen> createState() =>
      _UserOrderProgressScreenState();
}

class _UserOrderProgressScreenState extends State<UserOrderProgressScreen> {
  bool isAccepted = false;
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersCubit, OrdersState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        OrdersCubit cubit = OrdersCubit.get(context);
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: preferredSize,
            child: const CustomAppBar(
              title: "طلباتي",
            ),
          ),
          body: cubit.getSingleOrderLoading
              ? Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : ListView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  physics:
                      index == 2 ? const NeverScrollableScrollPhysics() : null,
                  children: [
                    StepperWidget(
                      index: cubit.getSingleOrderModel!.orderStatus ==
                              OrderStatusEnum.assigned.name
                          ? 1
                          : cubit.getSingleOrderModel!.orderStatus ==
                                  OrderStatusEnum.started.name
                              ? 2
                              : 3,
                    ),
                    const CustomSizedBox(
                      height: 24,
                    ),
                    Text(
                      cubit.getSingleOrderModel!.orderStatus ==
                              OrderStatusEnum.started.name
                          ? "قيد التنفيذ"
                          : cubit.getSingleOrderModel!.orderStatus ==
                                  OrderStatusEnum.finished.name
                              ? "تم الانتهاء"
                              : "طلب جديد",
                      style:
                          CustomThemes.primaryColorTextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: CustomFontWeights.bold,
                      ),
                    ),
                    const CustomSizedBox(
                      height: 16,
                    ),
                    if (cubit.getSingleOrderModel!.orderStatus !=
                            OrderStatusEnum.started.name &&
                        cubit.getSingleOrderModel!.orderStatus !=
                            OrderStatusEnum.finished.name)
                      FirstIndexComponent(
                        isAccepted: isAccepted,
                      ),
                    if (cubit.getSingleOrderModel!.orderStatus ==
                        OrderStatusEnum.started.name)
                      const SecondIndexComponent(),
                    if (cubit.getSingleOrderModel!.orderStatus ==
                        OrderStatusEnum.finished.name)
                      const ThirdIndexComponent(),
                    const CustomSizedBox(
                      height: 48,
                    ),
                  ],
                ),
          bottomNavigationBar: cubit.getSingleOrderModel!.orderStatus ==
                  OrderStatusEnum.started.name
              ? OrdersNavBarComponent(
                  onPressed: () {},
                )
              : null,
        );
      },
    );
  }
}
