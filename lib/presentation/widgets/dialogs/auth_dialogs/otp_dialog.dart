import 'package:car_wash/core/constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../business_logic/auth_cubit/auth_cubit.dart';
import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/app_theme/custom_font_weights.dart';
import '../../../../core/app_theme/custom_themes.dart';
import '../../../../core/constants/constants.dart';
import '../../auth_widgets/otp_builder.dart';
import '../../shared_widgets/custom_elevated_button.dart';
import '../../shared_widgets/custom_sized_box.dart';
import '../../shared_widgets/custom_text_button.dart';

class OtpDialog extends StatelessWidget {
  final String? otpCode;
  final String? phoneNumber;
  const OtpDialog({super.key, this.otpCode, this.phoneNumber,});

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
            "تم ارسال كود من 4 ارقام الى   *********${phoneNumber?.substring(8,10)} اكتب الكورد ادناه للتحقق من الرقم",
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
          OtpFieldBuilder(
            controller: TextEditingController(
              text: otpCode,
            ),
          ),
          const CustomSizedBox(
            height: 16,
          ),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is SendOtpSuccessState) {
                Navigator.pop(context);
                Navigator.pop(context);
                showToast(errorType: 0, message: "Registerd Successfully");
              }
              if (state is SendOtpLoadingState) {
                showProgressIndicator(context);
              }
              if (state is SendOtpErrorState) {
                Navigator.pop(context);
                showToast(errorType: 0, message: "Registerd Error");
              }
            },
            builder: (context, state) {
              var cubit = AuthCubit.get(context);
              return CustomElevatedButton(
                onPressed: () {
                  cubit.sendOtp(code: otpCode??"");
                  // Navigator.pushNamed(
                  //   context,
                  //   ScreenName.userHomeScreen,
                  // );
                },
                text: "تحقق",
                height: 48,
                width: double.infinity,
              );
            },
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
                    child: Text(
                      "اعادة ارسال",
                      style:
                      CustomThemes.primaryColorTextTheme(context).copyWith(
                        fontWeight: CustomFontWeights.bold,
                        fontSize: 16.sp,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryColor,
                      ),
                    ),
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
