import 'package:car_wash/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '../../../business_logic/orders_cubit/orders_cubit.dart';
import '../../../core/app_router/screens_name.dart';
import '../../../presentation/widgets/shared_widgets/custom_sized_box.dart';
import '../shared_widgets/custom_elevated_button.dart';
import '../shared_widgets/custom_text_form_field.dart';
import 'order_done_container.dart';
import 'rating_widget.dart';

class ThirdIndexComponent extends StatefulWidget {
  const ThirdIndexComponent({super.key});

  @override
  State<ThirdIndexComponent> createState() => _ThirdIndexComponentState();
}

class _ThirdIndexComponentState extends State<ThirdIndexComponent> {
  TextEditingController controller = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersCubit, OrdersState>(
      listener: (context, state) {
        if (state is RateOrderLoadingStates) {
          showProgressIndicator(context);
        } else if (state is RateOrderSuccessStates) {
          Phoenix.rebirth(context);
        } else if (state is RateOrderErrorStates) {
          Navigator.pop(context);
          showToast(
            errorType: 1,
            message: state.error,
          );
        }
      },
      builder: (context, state) {
        OrdersCubit cubit = OrdersCubit.get(context);
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DoneContainer(),
              const CustomSizedBox(
                height: 16,
              ),
              RatingWidget(
                title: 'تقييم المندوب',
                onRatingUpdate: cubit.updateRating,
              ),
              const CustomSizedBox(
                height: 16,
              ),
              CustomTextField(
                hintText: "ملاحظاتك",
                maxLines: 10,
                textAlignVertical: TextAlignVertical.top,
                controller: controller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "برجاء ادخال ملاحطاتك";
                  }
                  return null;
                },
              ),
              const CustomSizedBox(
                height: 16,
              ),
              CustomElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    cubit.rateOrder(
                      orderId: cubit.getSingleOrderModel!.id!.toString(),
                      rate: cubit.rating.toString(),
                      review: controller.text,
                    );
                  }
                },
                width: double.infinity,
                text: "ارسال",
                height: 48,
              ),
            ],
          ),
        );
      },
    );
  }
}
