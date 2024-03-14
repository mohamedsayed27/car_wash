import 'package:car_wash/core/app_router/screens_name.dart';
import 'package:car_wash/core/app_theme/custom_font_weights.dart';
import 'package:car_wash/core/app_theme/custom_themes.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/assets_path/images_path.dart';
import '../../../core/assets_path/svg_path.dart';
import '../../widgets/auth_widgets/phone_auth_field.dart';
import '../../widgets/dialogs/auth_dialogs/otp_dialog.dart';
import '../../widgets/shared_widgets/custom_elevated_button.dart';
import '../../widgets/auth_widgets/otp_builder.dart';
import '../../widgets/shared_widgets/custom_text_button.dart';
import '../../widgets/shared_widgets/form_item_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
          children: [
            const CustomSizedBox(
              height: 49,
            ),
            Text(
              "تسجيل الدخول",
              textAlign: TextAlign.center,
              style: CustomThemes.primaryColorTextTheme(context).copyWith(
                fontSize: 18.sp,
                fontWeight: CustomFontWeights.bold,
              ),
            ),
            const CustomSizedBox(
              height: 8,
            ),
            Text(
              "لقد تم توليد هذا النص من مولد النص العربى",
              textAlign: TextAlign.center,
              style: CustomThemes.greyColor7DTextTheme(context).copyWith(
                fontSize: 14.sp,
                fontWeight: CustomFontWeights.w400,
              ),
            ),
            const CustomSizedBox(
              height: 39,
            ),
            SvgPicture.asset(
              SvgPath.loginImage,
              height: 217.h,
              width: 203.w,
            ),
            const CustomSizedBox(
              height: 42,
            ),
            const PhoneAuthField(),
            const CustomSizedBox(
              height: 16,
            ),
            CustomElevatedButton(
                borderRadius: null,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => OtpDialog(isUser: true,),
                  );
                },
                text: "ارسال الرمز",
                height: 48),
            const CustomSizedBox(
              height: 24,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "ليس لديك جساب؟  ",
                style: CustomThemes.primaryColorTextTheme(context).copyWith(
                    fontWeight: CustomFontWeights.w500, fontSize: 16.sp),
                children: [
                  WidgetSpan(
                    child: CustomTextButton(
                      height: 26,
                      onPressed: () {
                        Navigator.pushNamed(context, ScreenName.registerScreen,);
                      },
                      child: Text("سجل الان",style: CustomThemes.primaryColorTextTheme(context).copyWith(
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
            const CustomSizedBox(
              height: 52,
            ),
            Image.asset(
              ImagesPath.loginLogo,
              width: 96.w,
              height: 94.h,
            ),
          ],
        ),
      ),
    );
  }
}
