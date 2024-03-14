import 'package:car_wash/core/app_theme/app_colors.dart';
import 'package:car_wash/core/assets_path/images_path.dart';
import 'package:car_wash/core/assets_path/svg_path.dart';
import 'package:car_wash/presentation/widgets/auth_widgets/phone_auth_field.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/constants/constants.dart';
import '../../widgets/bottom_sheets/add_address_bottom_sheet.dart';
import '../../widgets/profile_widgets/edit_profile_widgets/address_check_list.dart';
import '../../widgets/shared_widgets/custom_elevated_button.dart';
import '../../widgets/shared_widgets/custom_outlined_button.dart';
import '../../widgets/shared_widgets/custom_sized_box.dart';
import '../../widgets/shared_widgets/form_item_widget.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "الملف الشخصي",
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
        children: [
          Center(
            child: Stack(
              children: [
                Container(
                  height: 100.h,
                  width: 100.w,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: AppColors.primaryColor, width: 1.w),
                  ),
                  child: Image.asset(
                    ImagesPath.dummyPersonImage,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    height: 16.h,
                    width: 16.w,
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.shadowColor(value: .25),
                              offset: Offset.zero,
                              blurRadius: 1.r)
                        ]),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      SvgPath.edit,
                      height: 10.h,
                      width: 10.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const CustomSizedBox(
            height: 24,
          ),
          Text(
            "البيانات الشخصية",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
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
            controller: TextEditingController(text: "محمود سالم"),
          ),
          const CustomSizedBox(
            height: 16,
          ),
          Text(
            " رقم الهاتف",
            style: CustomThemes.greyColor71TextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: CustomFontWeights.bold,
            ),
          ),
          const CustomSizedBox(
            height: 8,
          ),
          PhoneAuthField(
            textEditingController: TextEditingController(text: "12345678910"),
          ),
          const CustomSizedBox(
            height: 8,
          ),
           FormItemWidget(
            title: "الايميل",
            hintText: "الايميل",
            controller: TextEditingController(text: "info@gmail.com"),
          ),
          const CustomSizedBox(
            height: 24,
          ),
          Text(
            "العناوين",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 18.sp,
              fontWeight: CustomFontWeights.bold,
            ),
          ),
          const CustomSizedBox(
            height: 16,
          ),
          const AddressCheckList(),
          const CustomSizedBox(
            height: 16,
          ),
          CustomOutlinedButton(
            borderColor: AppColors.greyColorB0,
            backgroundColor: AppColors.whiteColor,
            borderRadius: 6,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                isDismissible: false,
                builder: (_) {
                  return const AddAddressBottomSheet(title: 'اضافة عنوان',);
                },
              );
            },
            foregroundColor: AppColors.primaryColor,
            padding: EdgeInsets.symmetric(
              horizontal: 32.w,
              vertical: 14.h,
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  SvgPath.addIcon,
                  width: 12.w,
                  height: 12.h,
                ),
                const CustomSizedBox(
                  width: 4,
                ),
                Text(
                  "اضافة عنوان",
                  style: CustomThemes.greyColorB0TextTheme(context).copyWith(
                    fontSize: 14.sp,
                    fontWeight: CustomFontWeights.bold,
                  ),
                ),
              ],
            ),
          ),
          const CustomSizedBox(
            height: 16,
          ),
          CustomElevatedButton(
            onPressed: () {

            },
            text: "حفظ",
            width: double.infinity,
            height: 48,
          ),
          const CustomSizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
