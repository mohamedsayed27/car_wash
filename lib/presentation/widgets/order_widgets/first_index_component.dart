import 'package:flutter/material.dart';

import '../../../core/app_theme/app_colors.dart';
import '../shared_widgets/custom_elevated_button.dart';
import '../shared_widgets/custom_outlined_button.dart';
import '../shared_widgets/custom_sized_box.dart';
import '../shared_widgets/hint_container_widget.dart';
import '../shared_widgets/services_type_and_time_widget.dart';
import 'agent_component.dart';

class FirstIndexComponent extends StatelessWidget {
  final bool isAccepted;
  const FirstIndexComponent({super.key, required this.isAccepted});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ServiceTypeAndTimeWidget(),
        if (isAccepted)const CustomSizedBox(
          height: 24,
        ),
        if (isAccepted)AgentComponent(),
        const CustomSizedBox(
          height: 24,
        ),
        CustomElevatedButton(
          onPressed: () {},
          width: double.infinity,
          text: "تعديل",
          height: 48,
        ),
        const CustomSizedBox(
          height: 16,
        ),
        CustomOutlinedButton(
          onPressed: () {},
          width: double.infinity,
          foregroundColor: AppColors.primaryColor,
          text: "الغاء",
          height: 48,
          borderColor: AppColors.primaryColor,
          borderRadius: 8,
        ),
        if (isAccepted)const CustomSizedBox(
          height: 16,
        ),
        if (isAccepted)HintContainerWidget(),
      ],
    );
  }
}
