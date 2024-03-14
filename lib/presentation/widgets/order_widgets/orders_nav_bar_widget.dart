import 'package:car_wash/presentation/widgets/order_widgets/rating_widget.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../shared_widgets/agent_details_widget.dart';
import '../shared_widgets/custom_elevated_button.dart';
import '../shared_widgets/custom_sized_box.dart';
import 'order_done_container.dart';

class OrdersNavBarComponent extends StatelessWidget {
  final void Function()? onPressed;

  const OrdersNavBarComponent({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 38.w,vertical: 38.h,),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -2.h),
            blurRadius: 12.r,
            color: AppColors.shadowColor(value: 0.15),
          )
        ],
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.r),
          topLeft: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "توقيت الوصول",
                style: CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 16.sp,
                  fontWeight: CustomFontWeights.bold,
                ),
              ),
              Text(
                "9:00",
                style: CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 16.sp,
                  fontWeight: CustomFontWeights.bold,
                ),
              ),
            ],
          ),
          const CustomSizedBox(
            height: 16,
          ),
          Text(
            "المندوب في  طريقه اليك",
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
          const CustomSizedBox(
            height: 16,
          ),
          CustomElevatedButton(
            onPressed: onPressed,
            text: "انهاء الطلب",
            height: 48,
          ),
        ],
      ),
    );
  }
}
