import 'package:car_wash/core/app_theme/custom_font_weights.dart';
import 'package:car_wash/core/app_theme/custom_themes.dart';
import 'package:car_wash/core/assets_path/svg_path.dart';
import 'package:car_wash/core/constants/extensions.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_divider.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_router/screens_name.dart';
import '../../../core/app_theme/app_colors.dart';
import '../../../core/constants/constants.dart';
import '../../widgets/payment_widgets/payment_methods_component.dart';
import '../../widgets/shared_widgets/custom_app_bar.dart';
import '../../widgets/shared_widgets/custom_elevated_button.dart';
import '../../widgets/shared_widgets/custom_text_button.dart';
import '../../widgets/shared_widgets/hint_container_widget.dart';

class ChoosePaymentScreen extends StatelessWidget {
  const ChoosePaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "طرق الدفع",
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 32.h,
        ),
        children: [
          const PaymentMethodsComponent(),
          const CustomSizedBox(
            height: 24,
          ),
          Text(
            "اضافة كود خصم",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontWeight: CustomFontWeights.bold,
              fontSize: 16.sp,
            ),
          ),
          const CustomSizedBox(
            height: 8,
          ),
          CustomTextField(
            hintText: "اكتب الكود",
            prefixIcon: IconButton(
              onPressed: null,
              icon: SvgPicture.asset(
                SvgPath.coupon,
                height: 28.h,
                width: 28.w,
              ),
            ),
            suffixIcon: CustomTextButton(
              height: 23,
              onPressed: () {},
              child: Text(
                "اضافة الكود",
                style: CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontWeight: CustomFontWeights.bold,
                  fontSize: 14.sp,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primaryColor,
                ),
              ),
            ).onlyDirectionalPadding(end: 16),
          ),
          const CustomSizedBox(
            height: 24,
          ),
          Text(
            "الخدمات",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontWeight: CustomFontWeights.bold,
              fontSize: 16.sp,
            ),
          ),
          const CustomSizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "غسيل داخلي",
                style: CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 14.sp,
                  fontWeight: CustomFontWeights.w400,
                ),
              ),
              Text(
                "70 ريال",
                style: CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 14.sp,
                  fontWeight: CustomFontWeights.w400,
                ),
              ),
            ],
          ),
          const CustomSizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "اشتراك شهري 5 غسلات",
                style: CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 14.sp,
                  fontWeight: CustomFontWeights.w400,
                ),
              ),
              Text(
                "70 ريال",
                style: CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 14.sp,
                  fontWeight: CustomFontWeights.w400,
                ),
              ),
            ],
          ),
          const CustomSizedBox(
            height: 16,
          ),
          const CustomDivider(),
          const CustomSizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "الاجمالي",
                style: CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontWeight: CustomFontWeights.bold,
                  fontSize: 16.sp,
                ),
              ),
              Text(
                "140 ريال",
                style: CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 14.sp,
                  fontWeight: CustomFontWeights.w400,
                ),
              ),
            ],
          ),
          const CustomSizedBox(
            height: 24,
          ),
          const HintContainerWidget(),
          const CustomSizedBox(
            height: 16,
          ),
          CustomElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, ScreenName.userOrderProgressScreen);
            },
            width: double.infinity,
            text: "ادفع",
            height: 48,
          ),
        ],
      ),
    );
  }
}
