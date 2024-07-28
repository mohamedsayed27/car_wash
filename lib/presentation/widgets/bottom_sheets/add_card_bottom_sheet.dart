import '../../../core/constants/extensions.dart';
import '../../../presentation/widgets/shared_widgets/custom_divider.dart';
import '../../../presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';

import '../shared_widgets/custom_elevated_button.dart';
import '../shared_widgets/form_item_widget.dart';
import 'bottom_sheet_header_bar.dart';

class CardBottomSheet extends StatelessWidget {
  const CardBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomSizedBox(height: 8,),
            const BottomSheetHeaderBar(title: 'اضافة بطاقة',),
            const CustomDivider(),
            const CustomSizedBox(height: 16,),
            const FormItemWidget(
              title: "رقم البطاقة",
              hintText: "**** **** **** **** ",
            ),
            const CustomSizedBox(
              height: 16,
            ),
            const Row(
              children: [
                Expanded(
                  child: FormItemWidget(
                    title: "تاريخ الصلاحية",
                    hintText: "00/00",
                  ),
                ),
                CustomSizedBox(
                  width: 8,
                ),
                Expanded(
                  child: FormItemWidget(
                    title: "CVV",
                    hintText: "***",
                  ),
                ),
              ],
            ),
            const CustomSizedBox(height: 24,),
            CustomElevatedButton(
              onPressed: () {},
              width: double.infinity,
              text: "اضافة",
              height: 48,
            ),
          ],
        ).symmetricPadding(horizontal: 16,vertical: 8),
      ),
    );
  }
}
