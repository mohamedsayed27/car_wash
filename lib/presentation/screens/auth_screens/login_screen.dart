import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../business_logic/auth_cubit/auth_cubit.dart';
import '../../../core/app_router/screens_name.dart';
import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/assets_path/images_path.dart';
import '../../../core/assets_path/svg_path.dart';
import '../../../core/constants/constants.dart';
import '../../../core/parameters/auth_parameters/login_parameters.dart';
import '../../widgets/auth_widgets/phone_auth_field.dart';
import '../../widgets/dialogs/auth_dialogs/otp_dialog.dart';
import '../../widgets/shared_widgets/custom_elevated_button.dart';
import '../../widgets/shared_widgets/custom_sized_box.dart';
import '../../widgets/shared_widgets/custom_text_button.dart';
import '../../widgets/shared_widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final AuthCubit cubit;

  @override
  void initState() {
    cubit = AuthCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h,),
          children: [
            const CustomSizedBox(
              height: 24,
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
              height: 32,
            ),
            PhoneAuthField(
              textEditingController: cubit.loginPhoneController,
            ),
            // const CustomSizedBox(
            //   height: 16,
            // ),
            const CustomSizedBox(
              height: 16,
            ),
            CustomTextField(
              hintText: "ادخل كلمة المرور",
              // enabled: enabled,
              // filled: enabled == false ? true : null,
              // fillColor: enabled == false ? AppColors.greyColorB0 : null,
              controller: cubit.loginPasswordController,
            ),
            const CustomSizedBox(
              height: 24,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is LoginSuccessState) {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (_) => OtpDialog(
                      phoneNumber: state.loginModel?.result?.mobile,
                      otpCode: state.loginModel?.otpCode?.toString() ?? "",
                      // isUser: true,
                    ),
                  );
                }
                if (state is LoginLoadingState) {
                  showProgressIndicator(context);
                }
                if (state is LoginErrorState) {
                  Navigator.pop(context); 
                }
              },
              builder: (context, state) {
                return CustomElevatedButton(
                  borderRadius: null,
                  onPressed: () {
                    cubit.login(
                      loginParameters: LoginParameters(
                        mobileNumber: cubit.loginPhoneController.text,
                        password: cubit.loginPasswordController.text,
                      ),
                    );
                  },
                  text: "ارسال الرمز",
                  height: 48,
                );
              },
            ),
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
                        Navigator.pushNamed(
                          context,
                          ScreenName.registerScreen,
                        );
                      },
                      child: Text(
                        "سجل الان",
                        style: CustomThemes.primaryColorTextTheme(context)
                            .copyWith(
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
            const CustomSizedBox(
              height: 32,
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
