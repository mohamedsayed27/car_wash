import 'package:car_wash/core/app_router/screens_name.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/assets_path/images_path.dart';
import '../../../core/assets_path/svg_path.dart';
import '../../../core/constants/constants.dart';
import '../../widgets/auth_widgets/phone_auth_field.dart';
import '../../widgets/shared_widgets/custom_elevated_button.dart';
import '../../widgets/shared_widgets/custom_sized_box.dart';
import '../../widgets/shared_widgets/form_item_widget.dart';

class VendorProfileScreen extends StatelessWidget {
  const VendorProfileScreen({super.key});

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
            height: 16,
          ),
          CustomElevatedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, ScreenName.vendorHomeScreen, (route) => false);
            },
            text: "حفظ",
            width: double.infinity,
            height: 48,
          ),
        ],
      ),
    );
  }
}
