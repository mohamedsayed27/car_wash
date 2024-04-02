import 'package:car_wash/business_logic/orders_cubit/orders_cubit.dart';
import 'package:car_wash/business_logic/orders_cubit/orders_cubit.dart';
import 'package:car_wash/core/parameters/orders_parameters/add_orders_parameters.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_router/screens_name.dart';
import '../../../core/constants/constants.dart';
import '../../widgets/confirm_order_widgets/confirm_order_details_container.dart';
import '../../widgets/shared_widgets/custom_app_bar.dart';
import '../../widgets/shared_widgets/custom_elevated_button.dart';
import 'user_confirm_order_arguments.dart';

class UserConfirmOrderScreen extends StatelessWidget {
  final UserConfirmOrderArguments userConfirmOrderArguments;

  const UserConfirmOrderScreen(
      {super.key, required this.userConfirmOrderArguments});

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
          ConfirmOrderContainer(
            userConfirmOrderArguments: userConfirmOrderArguments,
          ),
          const CustomSizedBox(
            height: 24,
          ),
          BlocConsumer<OrdersCubit, OrdersState>(
            listener: (context, state) {
              if (state is MakeOrderSuccessState) {
                Navigator.pop(context);
                  showToast(errorType: 0, message: state.baseResponseModel.message??"",);
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
                showToast(errorType: 1, message: state.error??"",);
              }
            },
            builder: (context, state) {
              OrdersCubit cubit = OrdersCubit.get(context);
              return CustomElevatedButton(
                onPressed: () {
                  cubit.makeOrder(
                    addOrderParameters: AddOrderParameters(
                      userPlanId: userConfirmOrderArguments.allPlansModel.userPlanId.toString(),
                      serviceId: userConfirmOrderArguments.servicesModel.id.toString(),
                      carTypeId: userConfirmOrderArguments.carServicesArgument.contentImageModel!.id.toString(),
                      userAddressId: userConfirmOrderArguments.carServicesArgument.addressModel.id.toString(),
                      orderTimeId: userConfirmOrderArguments.timeModel.id.toString(),
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
