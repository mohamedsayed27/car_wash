import 'package:car_wash/core/enums/user_type_enum.dart';
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

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 32.h,
            ),
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
                height: 24,
              ),
              PhoneAuthField(
                textEditingController: cubit.loginPhoneController,
              ),
              const CustomSizedBox(
                height: 16,
              ),
              CustomTextField(
                hintText: "ادخل كلمة المرور",
                isNotVisible: true,
                maxLines: 1,
                validator: (value){
                  if(value!.isEmpty){
                    return "ادخل الرقم السري";
                  }
                  return null;
                },
                controller: cubit.loginPasswordController,
              ),
              const CustomSizedBox(
                height: 32,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is LoginSuccessState) {
                    Navigator.pop(context);
                    if (state.loginModel?.otpCode != null) {
                      showDialog(
                        context: context,
                        builder: (_) => OtpDialog(
                          phoneNumber: state.loginModel?.result?.mobile,
                          otpCode: state.loginModel?.otpCode?.toString() ?? "",
                          token: state.loginModel?.token,
                          // isUser: true,
                        ),
                      );

                    } else {
                      AuthCubit.get(context).handleCache(
                        token: state.loginModel?.token,
                        userType: state.loginModel?.result?.type?.toLowerCase(),
                        userId: state.loginModel?.result?.id,
                        name: state.loginModel?.result?.name,
                        email: state.loginModel?.result?.email,
                        phone: state.loginModel?.result?.mobile,
                      );
                      showToast(
                        errorType: 0,
                        message: state.loginModel?.message ?? "",
                      );
                      if (state.loginModel?.result?.type?.toLowerCase() ==
                          UserTypeEnum.client.name) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          ScreenName.userHomeScreen,
                          (route) => false,
                        );
                      } else {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          ScreenName.vendorHomeScreen,
                          (route) => false,
                        );
                      }
                    }
                  }
                  if (state is LoginLoadingState) {
                    showProgressIndicator(context);
                  }
                  if (state is LoginErrorState) {
                    Navigator.pop(context);
                    showToast(
                      errorType: 1,
                      message: state.error,
                    );
                  }
                },
                builder: (context, state) {
                  return CustomElevatedButton(
                    borderRadius: null,
                    onPressed: () {

                     if(formKey.currentState!.validate()){
                       cubit.login(
                         loginParameters: LoginParameters(
                           mobileNumber: cubit.loginPhoneController.text,
                           password: cubit.loginPasswordController.text,
                         ),
                       );
                     }
                    },
                    text: "ارسال الرمز",
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
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
      ),
    );
  }
}
