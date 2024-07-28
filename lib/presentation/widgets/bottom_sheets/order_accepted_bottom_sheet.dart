import '../../../core/constants/extensions.dart';
import '../../../presentation/widgets/shared_widgets/custom_divider.dart';
import '../../../presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../shared_widgets/agent_details_widget.dart';
import 'bottom_sheet_header_bar.dart';

class OrderAcceptedBottomSheet extends StatelessWidget {
  const OrderAcceptedBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomSizedBox(height: 8,),
            const BottomSheetHeaderBar(title: 'تم قبول الطلب',),
            const CustomDivider(),
            const CustomSizedBox(height: 16,),
            Text(
              "تم قبول طلبك من قبل أحد مناديبنا لاي استفسارات يمكنك التواصل مع ",
              style: CustomThemes.greyColorB0TextTheme(context).copyWith(
                fontSize: 14.sp,
                fontWeight: CustomFontWeights.w600,
              ),
            ),
            const CustomSizedBox(
              height: 24,
            ),
            Text(
              "مندوبك اليوم",
              style: CustomThemes.primaryColorTextTheme(context).copyWith(
                fontSize: 16.sp,
                fontWeight: CustomFontWeights.bold,
              ),
            ),
            const CustomSizedBox(
              height: 16,
            ),
            const AgentDetailsWidget(),
          ],
        ).symmetricPadding(horizontal: 16,vertical: 8),
      ),
    );
  }
}
