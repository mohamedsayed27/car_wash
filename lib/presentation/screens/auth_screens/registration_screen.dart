import 'package:car_wash/core/app_theme/app_colors.dart';
import 'package:car_wash/core/assets_path/svg_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../business_logic/auth_cubit/auth_cubit.dart';
import '../../../core/app_router/screens_name.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
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
              cubit.registerFirstNameController.clear();
              cubit.registerLastNameController.clear();
              cubit.registerPhoneController.clear();
              cubit.registerPasswordController.clear();
              cubit.profileImage=null;
              showToast(errorType: 0, message: "Registered Success Go Login");
            }
            if (state is RegisterLoadingState) {
              showProgressIndicator(context);
            }
            if (state is RegisterErrorState) {
              Navigator.pop(context);
              showToast(errorType: 1, message: "Register Error");
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
                  alignment: cubit.profileImage == null?Alignment.bottomCenter:null,
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
                  ),),
                ),
                const CustomSizedBox(
                  height: 24,
                ),
                PhoneAuthField(
                  textEditingController: cubit.registerPhoneController,
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                FormItemWidget(
                  title: "الاسم الاول",
                  hintText: "الاسم الاول",
                  controller: cubit.registerFirstNameController,
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                FormItemWidget(
                  title: "الاسم الثاني",
                  hintText: "الاسم الثاني",
                  controller: cubit.registerLastNameController,
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                FormItemWidget(
                  title: "البريد الالكتروني",
                  hintText: "البريد الالكتروني",
                  controller: cubit.registerEmailController,
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                FormItemWidget(
                  title: "كلمة المرور",
                  hintText: "كلمة المرور",
                  controller: cubit.registerPasswordController,
                ),
                const CustomSizedBox(
                  height: 32,
                ),
                CustomElevatedButton(
                  onPressed: () {
                    cubit.register(
                      registerParameters: RegisterParameters(
                        name: "${cubit.registerFirstNameController.text} ${cubit.registerLastNameController.text}",
                        mobileNumber: cubit.registerPhoneController.text,
                        password: cubit.registerPasswordController.text,
                        avatar: cubit.profileImage!,
                      ),
                    );
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
