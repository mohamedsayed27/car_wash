import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_router/screens_name.dart';
import '../../../core/constants/constants.dart';
import '../../widgets/confirm_order_widgets/confirm_order_details_container.dart';
import '../../widgets/shared_widgets/custom_app_bar.dart';
import '../../widgets/shared_widgets/custom_elevated_button.dart';

class UserConfirmOrderScreen extends StatelessWidget {
  const UserConfirmOrderScreen({super.key});

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
          const ConfirmOrderContainer(),
          const CustomSizedBox(
            height: 24,
          ),
          CustomElevatedButton(
            onPressed: () {

              Navigator.pushNamed(context, ScreenName.choosePaymentScreen);
            },
            width: double.infinity,
            text: "صفحة الدفع",
            height: 48,
          )
        ],
      ),
    );
  }
}