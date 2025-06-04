import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../business_logic/auth_cubit/auth_cubit.dart';
import '../../../core/app_router/screens_name.dart';
import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/assets_path/svg_path.dart';
import '../../../core/constants/constants.dart';
import '../../../core/parameters/auth_parameters/register_parameters.dart';
import '../../widgets/auth_widgets/phone_auth_field.dart';
import '../../widgets/shared_widgets/custom_elevated_button.dart';
import '../../widgets/shared_widgets/custom_sized_box.dart';
import '../../widgets/shared_widgets/custom_text_button.dart';
import '../../widgets/shared_widgets/form_item_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({
    super.key,
  });

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late final AuthCubit cubit;

  final TextEditingController registerFirstNameController =
      TextEditingController();
  final TextEditingController registerLastNameController =
      TextEditingController();
  final TextEditingController registerPhoneController = TextEditingController(
      text: "",
    );
  final TextEditingController registerPasswordController =
      TextEditingController();
  final TextEditingController registerEmailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cubit = AuthCubit.get(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is GetPickedImageSuccessState) {
              cubit.profileImage = state.pickedImage;
            }
            if (state is RegisterSuccessState) {
              Navigator.pop(context);
              Navigator.pop(context);

              cubit.profileImage = null;
              showToast(
                errorType: 0,
                message: "تم التسجيل بنجاح اذهب لتسجيل الدخول",
              );
            }
            if (state is RegisterLoadingState) {
              showProgressIndicator(context);
            }
            if (state is RegisterErrorState) {
              Navigator.pop(context);
              showToast(
                errorType: 1,
                message: state.error,
              );
            }
          },
          builder: (context, state) {
            return ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 32.h,
              ),
              children: [
                const CustomSizedBox(
                  height: 49,
                ),
                Text(
                  "التسجيل",
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
                  alignment: cubit.profileImage == null
                      ? Alignment.bottomCenter
                      : null,
                  clipBehavior: Clip.antiAlias,
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
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      cubit.getImagePick();
                    },
                    child: cubit.profileImage == null
                        ? SvgPicture.asset(
                            SvgPath.person,
                            width: 71.w,
                            height: 98.h,
                          )
                        : Image.file(
                            cubit.profileImage!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const CustomSizedBox(
                  height: 24,
                ),
                PhoneAuthField(
                  textEditingController: registerPhoneController,
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                FormItemWidget(
                  title: "الاسم الاول",
                  hintText: "الاسم الاول",
                  controller: registerFirstNameController,
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                FormItemWidget(
                  title: "الاسم الثاني",
                  hintText: "الاسم الثاني",
                  controller: registerLastNameController,
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                FormItemWidget(
                  title: "البريد الالكتروني",
                  hintText: "البريد الالكتروني",
                  controller: registerEmailController,
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                FormItemWidget(
                  title: "كلمة المرور",
                  hintText: "كلمة المرور",
                  controller: registerPasswordController,
                ),
                const CustomSizedBox(
                  height: 32,
                ),
                CustomElevatedButton(
                  onPressed: () {
                    if(cubit.profileImage!=null) {
                      cubit.register(
                      registerParameters: RegisterParameters(
                        name:
                            "${registerFirstNameController.text.trim()} ${registerLastNameController.text.trim()}",
                        mobileNumber:
                            registerPhoneController.text,
                        password: registerPasswordController.text,
                        avatar: cubit.profileImage!,
                      ),
                    );
                    }else{
                      showToast(errorType: 1, message: "برجاء اختيار صورة",);
                    }
                  },
                  text: "تسجيل",
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
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
                            Navigator.pushReplacementNamed(
                              context,
                              ScreenName.loginScreen,
                            );
                          },
                          child: Text(
                            "سجل الدخول",
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
              ],
            );
          },
        ),
      ),
    );
  }
}
