import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';

import '../../../core/app_router/screens_name.dart';
import '../shared_widgets/custom_elevated_button.dart';
import '../shared_widgets/custom_text_form_field.dart';
import 'order_done_container.dart';
import 'rating_widget.dart';

class ThirdIndexComponent extends StatelessWidget {
  const ThirdIndexComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DoneContainer(),
        const CustomSizedBox(
          height: 16,
        ),
        const RatingWidget(
          title: 'تقييم الخدمة',
        ),
        const CustomSizedBox(
          height: 16,
        ),
        const RatingWidget(
          title: 'تقييم المندوب',
        ),
        const CustomSizedBox(
          height: 16,
        ),
        const CustomTextField(
          hintText: "ملاحظاتك",
          maxLines: 10,
          textAlignVertical: TextAlignVertical.top,
        ),
        const CustomSizedBox(
          height: 16,
        ),
        CustomElevatedButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, ScreenName.userHomeScreen,(routes)=>false);
          },
          width: double.infinity,
          text: "ارسال",
          height: 48,
        ),
      ],
    );
  }
}
