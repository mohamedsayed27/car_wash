import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/app_theme/app_colors.dart';

class OtpFieldBuilder extends StatelessWidget {
  final TextEditingController? controller;

  const OtpFieldBuilder({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      controller: controller,
      appContext: context,
      length: 4,
      autoFocus: false,
      cursorColor: Colors.black,
      obscureText: false,
      hintCharacter: "-",
      textStyle: TextStyle(fontSize: 16.sp, color: AppColors.primaryColor),
      hintStyle: TextStyle(fontSize: 16.sp, color: AppColors.greyColorB0),
      keyboardType: TextInputType.phone,
      animationType: AnimationType.scale,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8.r),
        fieldHeight: 40.h,
        fieldWidth: 40.w,
        borderWidth: 0.61.w,
        activeFillColor: const Color(0xffEFF7FE),
        selectedFillColor: AppColors.whiteColor,
        activeColor: AppColors.primaryColor,
        selectedColor: AppColors.primaryColor,
        inactiveColor: AppColors.greyColor22,
        inactiveFillColor: AppColors.whiteColor,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      onCompleted: (code) {},
      onChanged: (value) {},
    );
  }
}
