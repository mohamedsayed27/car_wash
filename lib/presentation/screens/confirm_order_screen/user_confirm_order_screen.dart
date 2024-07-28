import '../../../business_logic/orders_cubit/orders_cubit.dart';
import '../../../business_logic/plans_cubit/plans_cubit.dart';
import '../../../core/parameters/orders_parameters/add_orders_parameters.dart';
import '../../../presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_router/screens_name.dart';
import '../../../core/constants/constants.dart';
import '../../widgets/confirm_order_widgets/confirm_order_details_container.dart';
import '../../widgets/shared_widgets/custom_app_bar.dart';
import '../../widgets/shared_widgets/custom_elevated_button.dart';
import 'user_confirm_order_arguments.dart';

class UserConfirmOrderScreen extends StatefulWidget {
  final UserConfirmOrderArguments userConfirmOrderArguments;

  const UserConfirmOrderScreen({
    super.key,
    required this.userConfirmOrderArguments,
  });

  @override
  State<UserConfirmOrderScreen> createState() => _UserConfirmOrderScreenState();
}

class _UserConfirmOrderScreenState extends State<UserConfirmOrderScreen> {
  late bool usePlan;

  @override
  void initState() {
    super.initState();
    usePlan = widget.userConfirmOrderArguments.allPlansModel != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "تأكيد الطلب",
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
        children: [
          UserConfirmOrderContainer(
            userConfirmOrderArguments: widget.userConfirmOrderArguments,
          ),
          if (PlansCubit.get(context).plansList.any((e) => e.isSubscribed != 0))
            const CustomSizedBox(
              height: 16,
            ),
          if (PlansCubit.get(context).plansList.any((e) => e.isSubscribed != 0))
            Row(
              children: [
                Checkbox(
                  value: usePlan,
                  onChanged: (value) {
                    usePlan = value!;
                    setState(() {});
                  },
                  visualDensity: const VisualDensity(
                    vertical: VisualDensity.minimumDensity,
                    horizontal: VisualDensity.minimumDensity,
                  ),
                ),
                Expanded(
                  child: Text(
                    "انت مشترك في باقة ${PlansCubit.get(context).plansList.firstWhere((element) => element.isSubscribed == 1).name} ولديك عدد ${PlansCubit.get(context).plansList.firstWhere((element) => element.isSubscribed == 1).washNumber} غسلة متبقي هل تود استخدام الاشتراك",
                  ),
                ),
              ],
            ),
          const CustomSizedBox(
            height: 24,
          ),
          BlocConsumer<OrdersCubit, OrdersState>(
            listener: (context, state) {
              if (state is MakeOrderSuccessState) {
                Navigator.pop(context);
                showToast(
                  errorType: 0,
                  message: state.baseResponseModel.message ?? "",
                );
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  ScreenName.userHomeScreen,
                  (route) => false,
                );
              }
              if (state is MakeOrderLoadingState) {
                showProgressIndicator(context);
              }
              if (state is MakeOrderErrorState) {
                Navigator.pop(context);
                showToast(
                  errorType: 1,
                  message: state.error ?? "",
                );
              }
            },
            builder: (context, state) {
              OrdersCubit cubit = OrdersCubit.get(context);
              return CustomElevatedButton(
                onPressed: () {
                  cubit.makeOrder(
                    addOrderParameters: AddOrderParameters(
                      userPlanId: widget
                          .userConfirmOrderArguments.allPlansModel?.userPlanId
                          .toString(),
                      serviceId: widget
                          .userConfirmOrderArguments.servicesModel?.id
                          .toString(),
                      carTypeId: widget.userConfirmOrderArguments
                          .carServicesArgument?.contentImageModel!.id
                          .toString(),
                      userAddressId: widget.userConfirmOrderArguments
                          .carServicesArgument?.addressModel.id
                          .toString(),
                      orderTimeId: widget
                          .userConfirmOrderArguments.timeModel?.id
                          .toString(),
                    ),
                  );
                  // Navigator.pushNamed(context, ScreenName.choosePaymentScreen);
                },
                width: double.infinity,
                text: "تأكيد",
                height: 48,
              );
            },
          )
        ],
      ),
    );
  }
}
