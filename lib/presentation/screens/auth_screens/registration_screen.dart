import 'package:car_wash/core/app_theme/app_colors.dart';
import 'package:car_wash/core/assets_path/svg_path.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/form_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_router/screens_name.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../widgets/auth_widgets/phone_auth_field.dart';
import '../../widgets/dialogs/auth_dialogs/otp_dialog.dart';
import '../../widgets/shared_widgets/custom_elevated_button.dart';
import '../../widgets/shared_widgets/custom_sized_box.dart';
import '../../widgets/shared_widgets/custom_text_button.dart';

class RegistrationScreen extends StatelessWidget {
  final bool isUser;
  const RegistrationScreen({super.key, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 32.h,
          ),
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
              height: 24,
            ),
            Container(
              height: 136.h,
              width: 136.w,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondaryColor,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, -2.h),
                    color: AppColors.shadowColor(),
                    blurRadius: 16.r,
                  )
                ],
              ),
              child: SvgPicture.asset(
                SvgPath.person,
                width: 71.w,
                height: 98.h,
              ),
            ),
            const CustomSizedBox(
              height: 24,
            ),
            const PhoneAuthField(),
            const CustomSizedBox(
              height: 16,
            ),
            const FormItemWidget(
              title: "الاسم الاول",
              hintText: "نص تلقائي",
            ),
            const CustomSizedBox(
              height: 16,
            ),
            const FormItemWidget(
              title: "الاسم الثاني",
              hintText: "نص تلقائي",
            ),
            const CustomSizedBox(
              height: 16,
            ),
            const FormItemWidget(
              title: "البريد الالكتروني",
              hintText: "نص تلقائي",
            ),
            const CustomSizedBox(
              height: 32,
            ),
            CustomElevatedButton(
              onPressed: () {

                showDialog(
                  context: context,
                  builder: (_) => OtpDialog(isUser: isUser,),
                );
              },
              text: "ارسال الرمز",
              height: 48,
            ),
            const CustomSizedBox(
              height: 16,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "لديك جساب بالفعل؟  ",
                style: CustomThemes.primaryColorTextTheme(context).copyWith(
                    fontWeight: CustomFontWeights.w500, fontSize: 16.sp),
                children: [
                  WidgetSpan(
                    child: CustomTextButton(
                      height: 26,
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, ScreenName.loginScreen,);
                      },
                      child: Text("سجل الدخول",style: CustomThemes.primaryColorTextTheme(context).copyWith(
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
        ),
      ),
    );
  }
}
