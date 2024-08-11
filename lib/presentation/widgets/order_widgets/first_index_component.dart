import 'package:car_wash/business_logic/orders_cubit/orders_cubit.dart';
import 'package:car_wash/business_logic/orders_cubit/orders_cubit.dart';
import 'package:car_wash/core/enums/order_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/constants/constants.dart';
import '../../../data/models/order_models/single_order_model.dart';
import '../shared_widgets/custom_elevated_button.dart';
import '../shared_widgets/custom_outlined_button.dart';
import '../shared_widgets/custom_sized_box.dart';
import '../shared_widgets/hint_container_widget.dart';
import '../shared_widgets/services_type_and_time_widget.dart';
import 'agent_component.dart';

class FirstIndexComponent extends StatelessWidget {
  final bool isAccepted;
  final SingleOrderModel? singleOrderModel;

  const FirstIndexComponent({
    super.key,
    required this.isAccepted,
    this.singleOrderModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ServiceTypeAndTimeWidget(
          singleOrderModel: singleOrderModel,
        ),
        if (isAccepted)
          const CustomSizedBox(
            height: 24,
          ),
        if (isAccepted)  AgentComponent(representative: singleOrderModel?.representative,),
        const CustomSizedBox(
          height: 24,
        ),
        // CustomElevatedButton(
        //   onPressed: () {},
        //   width: double.infinity,
        //   text: "تعديل",
        //   height: 48,
        // ),
        // const CustomSizedBox(
        //   height: 16,
        // ),
        if(singleOrderModel?.orderStatus ==OrderStatusEnum.assigned.name||singleOrderModel?.orderStatus ==OrderStatusEnum.pending.name) BlocConsumer<OrdersCubit, OrdersState>(
          listener: (context, state) {
            if (state is DeleteOrderSuccessStates) {
              Navigator.pop(context);
              showToast(
                errorType: 0,
                message: state.baseResponseModel?.message ?? "",
              );
              Phoenix.rebirth(context);

            }
            if (state is DeleteOrderLoadingStates) {
              showProgressIndicator(context);
            }
            if (state is DeleteOrderErrorStates) {
              Navigator.pop(context);
              showToast(
                errorType: 1,
                message: state.error ?? "",
              );
            }
          },
          builder: (context, state) {
            OrdersCubit cubit = OrdersCubit.get(context);
            return CustomOutlinedButton(
              onPressed: () {
                cubit.deleteOrder(id: singleOrderModel!.id.toString());
              },
              width: double.infinity,
              foregroundColor: AppColors.primaryColor,
              text: "الغاء",
              height: 48,
              borderColor: AppColors.primaryColor,
              borderRadius: 8,
            );
          },
        ),
        if (isAccepted)
          const CustomSizedBox(
            height: 16,
          ),
        if(singleOrderModel?.orderStatus ==OrderStatusEnum.assigned.name||singleOrderModel?.orderStatus ==OrderStatusEnum.pending.name) if (isAccepted) const HintContainerWidget(),
      ],
    );
  }
}
