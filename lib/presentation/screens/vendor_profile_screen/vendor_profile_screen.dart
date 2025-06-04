import '../../../core/parameters/auth_parameters/update_profile_parameters.dart';
import '../../../presentation/widgets/shared_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../business_logic/auth_cubit/auth_cubit.dart';
import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/assets_path/svg_path.dart';
import '../../../core/constants/constants.dart';
import '../../widgets/auth_widgets/phone_auth_field.dart';
import '../../widgets/shared_widgets/cached_network_image_widget.dart';
import '../../widgets/shared_widgets/custom_elevated_button.dart';
import '../../widgets/shared_widgets/custom_sized_box.dart';
import '../../widgets/shared_widgets/form_item_widget.dart';

class VendorProfileScreen extends StatefulWidget {
  const VendorProfileScreen({super.key});

  @override
  State<VendorProfileScreen> createState() => _VendorProfileScreenState();
}

class _VendorProfileScreenState extends State<VendorProfileScreen> {
  @override
  void initState() {
    AuthCubit.get(context).getUserData();
    super.initState();
  }

  TextEditingController emailContainer = TextEditingController();
  TextEditingController passwordContainer = TextEditingController();
  TextEditingController phoneContainer = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "الملف الشخصي",
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          if (state is GetPickedImageSuccessState) {
            cubit.profileImage = state.pickedImage;
          }
          if (state is UpdateProfileSuccessState) {
            Navigator.pop(context);
            cubit.profileImage = null;
            cubit.getUserData();
            showToast(
              errorType: 0,
              message: "تم تحديث البيانات",
            );
          }
          if (state is UpdateProfileLoadingState) {
            showProgressIndicator(context);
          }
          if (state is UpdateProfileErrorState) {
            Navigator.pop(context);
            showToast(
              errorType: 1,
              message: state.error,
            );
          }
        },
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return cubit.getUserDataLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : ListView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  children: [
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
                            ? cubit.image==null?SvgPicture.asset(
                                SvgPath.person,
                                width: 71.w,
                                height: 98.h,
                              ):CachedNetworkImageWidget(imagePath:cubit.image!,fit: BoxFit.cover,width: double.infinity,height: double.infinity,)
                            : Image.file(
                                cubit.profileImage!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const CustomSizedBox(
                      height: 24,
                    ),
                    Text(
                      "البيانات الشخصية",
                      style:
                          CustomThemes.primaryColorTextTheme(context).copyWith(
                        fontSize: 18.sp,
                        fontWeight: CustomFontWeights.bold,
                      ),
                    ),
                    const CustomSizedBox(
                      height: 16,
                    ),
                    FormItemWidget(
                      title: "الاسم",
                      hintText: "الاسم",
                      controller: cubit.nameController,
                    ),
                    const CustomSizedBox(
                      height: 8,
                    ),
                    FormItemWidget(
                      title: "الايميل",
                      hintText: "الايميل",
                      controller: cubit.emailController,
                    ),
                    const CustomSizedBox(
                      height: 16,
                    ),
                    Text(
                      " رقم الهاتف",
                      style:
                          CustomThemes.greyColor71TextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: CustomFontWeights.bold,
                      ),
                    ),
                    const CustomSizedBox(
                      height: 8,
                    ),
                    PhoneAuthField(
                      textEditingController: cubit.phoneController,
                    ),
                    const CustomSizedBox(
                      height: 16,
                    ),
                    CustomElevatedButton(
                      onPressed: () {
                        // print(cubit.profileImage);
                        cubit.updateProfileData(
                          updateProfileParameters: UpdateProfileParameters(
                            name: cubit.nameController.text,
                            email: cubit.emailController.text,
                            phone: cubit.phoneController.text, avatar: cubit.profileImage,
                          ),
                        );
                        // Navigator.pushNamedAndRemoveUntil(context,
                        //     ScreenName.vendorHomeScreen, (route) => false);
                      },
                      text: "حفظ",
                      width: double.infinity,
                      height: 48,
                    ),
                  ],
                );
        },
      ),
    );
  }
}
