
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/constants/constants.dart';
import '../../widgets/bottom_sheets/order_accepted_bottom_sheet.dart';
import '../../widgets/order_widgets/first_index_component.dart';
import '../../widgets/order_widgets/orders_nav_bar_widget.dart';
import '../../widgets/order_widgets/second_index_component.dart';
import '../../widgets/order_widgets/stepper_widget.dart';
import '../../widgets/order_widgets/third_index_component.dart';
import '../../widgets/shared_widgets/custom_app_bar.dart';
import '../../widgets/shared_widgets/custom_elevated_button.dart';
import '../../widgets/shared_widgets/custom_sized_box.dart';

class UserOrderProgressScreen extends StatefulWidget {
  const UserOrderProgressScreen({super.key});

  @override
  State<UserOrderProgressScreen> createState() => _UserOrderProgressScreenState();
}

class _UserOrderProgressScreenState extends State<UserOrderProgressScreen> {
  bool isAccepted = false;
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "طلباتي",
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        physics: index==2?const NeverScrollableScrollPhysics():null,
        children: [
          StepperWidget(
            index: index,
          ),
          const CustomSizedBox(
            height: 24,
          ),
          Text(
            index == 1
                ? "طلب جديد"
                : index == 2
                    ? "قيد التنفيذ"
                    : "تم الانتهاء",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: CustomFontWeights.bold,
            ),
          ),
          const CustomSizedBox(
            height: 16,
          ),
          if (index == 1)
            FirstIndexComponent(
              isAccepted: isAccepted,
            ),
          if (index == 2)
            const SecondIndexComponent(),
          if (index == 3)
            const ThirdIndexComponent(),
          const CustomSizedBox(
            height: 48,
          ),
          Row(
            children: [
              if (!isAccepted)
                CustomElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => const OrderAcceptedBottomSheet(),
                      isScrollControlled: true,
                    ).then((value) {
                      setState(() {
                        isAccepted = true;
                      });
                    });
                  },
                  text: "قبول الطلب",
                  height: 48,
                ),
              if (isAccepted && index < 2)
                CustomElevatedButton(
                  onPressed: () {
                    setState(() {
                      index = 2;
                    });
                  },
                  text: "متابعه المندوب",
                  height: 48,
                ),
            ],
          )
        ],
      ),
      bottomNavigationBar: index==2? OrdersNavBarComponent(
        onPressed: (){
          setState(() {
            index = 3;
          });
        },
      ):null,
    );
  }
}
