import 'package:car_wash/core/app_router/screens_name.dart';
import 'package:car_wash/core/constants/extensions.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../data/models/car_types_model/car_types_model.dart';
import '../../widgets/car_services_widgets/car_type_services_widget.dart';
import '../../widgets/car_services_widgets/main_services_component.dart';
import '../../widgets/car_services_widgets/monthly_subscriptions_component.dart';
import '../../widgets/shared_widgets/custom_app_bar.dart';
import '../../widgets/shared_widgets/custom_elevated_button.dart';
import '../../widgets/shared_widgets/select_date_component.dart';
import '../../widgets/shared_widgets/select_time_component.dart';
part 'car_services_argument.dart';
class CarServicesScreen extends StatelessWidget {
  final CarServicesArgument carServicesArgument;
  const CarServicesScreen({super.key, required this.carServicesArgument});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: preferredSize, child: const CustomAppBar(title: "خدمات سيارتك"),),
      body: ListView(
        children: [
          CarTypeService(contentImageModel: carServicesArgument.contentImageModel,),
          const CustomSizedBox(height: 24,),
          const MainServicesComponent(),
          const CustomSizedBox(height: 24,),
          const MonthlySubscriptionsComponent(),
          const CustomSizedBox(height: 24,),
          const SelectDateComponent(),
          const CustomSizedBox(height: 24,),
          const SelectTimeComponent(),
          const CustomSizedBox(height: 24,),
          CustomElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, ScreenName.userConfirmOrderScreen);
            },
            width: double.infinity,
            text: "المتابعة",
            height: 48,
          ).symmetricPadding(horizontal: 16),
          const CustomSizedBox(height: 24,),
        ],
      ),
    );
  }
}
