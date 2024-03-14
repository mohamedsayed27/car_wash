import 'package:car_wash/core/app_router/screens_name.dart';
import 'package:car_wash/core/app_theme/app_colors.dart';
import 'package:car_wash/core/constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_theme/custom_font_weights.dart';
import '../../../../core/app_theme/custom_themes.dart';
import '../../auth_widgets/otp_builder.dart';
import '../../shared_widgets/custom_elevated_button.dart';
import '../../shared_widgets/custom_sized_box.dart';
import '../../shared_widgets/custom_text_button.dart';

class OtpDialog extends StatelessWidget {
  final bool isUser;
  const OtpDialog({super.key, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      elevation: 0,
      surfaceTintColor: AppColors.whiteColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "اكتب رمز التحقق الخاص بك ",
            textAlign: TextAlign.center,
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 18.sp,
              fontWeight: CustomFontWeights.bold,
            ),
          ),
          const CustomSizedBox(
            height: 4,
          ),
          Text(
            "تم ارسال كود من 4 ارقام الى   *********698 اكتب الكورد ادناه للتحقق من الرقم",
            textAlign: TextAlign.center,
            style: CustomThemes.greyColor7DTextTheme(context).copyWith(
              fontSize: 14.sp,
              height: 1.2.h,
              fontWeight: CustomFontWeights.w400,
            ),
          ),
          const CustomSizedBox(
            height: 16,
          ),
          const OtpFieldBuilder(),
          const CustomSizedBox(
            height: 16,
          ),
          CustomElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, isUser?ScreenName.userHomeScreen:ScreenName.vendorHomeScreen);
            },
            text: "تحقق",
            height: 48,
            width: double.infinity,
          ),
          const CustomSizedBox(
            height: 16,
          ),
          RichText(
            text: TextSpan(
              text: "اذا لم تستقبل الكود. ",
              style: CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontWeight: CustomFontWeights.w500, fontSize: 16.sp),
              children: [
                WidgetSpan(
                  child: CustomTextButton(
                    height: 26,
                    onPressed: () {},
                    child: Text("اعادة ارسال",style: CustomThemes.primaryColorTextTheme(context).copyWith(
                      fontWeight: CustomFontWeights.bold,
                      fontSize: 16.sp,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primaryColor,
                    ),),
                  ),
                ),
              ],
            ),
          ),
        ],
      ).symmetricPadding(horizontal: 32, vertical: 32),
    );
  }
}
