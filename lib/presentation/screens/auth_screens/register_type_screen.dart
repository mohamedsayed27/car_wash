import 'package:car_wash/core/app_router/screens_name.dart';
import 'package:car_wash/core/app_theme/app_colors.dart';
import 'package:car_wash/core/app_theme/custom_themes.dart';
import 'package:car_wash/core/assets_path/svg_path.dart';
import 'package:car_wash/core/constants/extensions.dart';
import 'package:car_wash/presentation/widgets/order_widgets/stepper_widget.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_app_bar.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/constants.dart';
import '../../widgets/shared_widgets/custom_elevated_button.dart';

class RegisterTypeScreen extends StatefulWidget {
  const RegisterTypeScreen({super.key});

  @override
  State<RegisterTypeScreen> createState() => _RegisterTypeScreenState();
}

class _RegisterTypeScreenState extends State<RegisterTypeScreen> {
  int? currentIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "اختار نوع الحساب",
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RegisterTypeButton(
                iconPath: SvgPath.userType,
                title: "مستخدم",
                isSelected: currentIndex == 1,
                onPressed: () {
                  currentIndex = 1;
                  setState(() {});
                },
              ),
              RegisterTypeButton(
                iconPath: SvgPath.driverType,
                title: "مندوب",
                isSelected: currentIndex == 2,
                onPressed: () {
                  currentIndex = 2;
                  setState(() {});
                },
              ),
            ],
          ).symmetricPadding(horizontal: 40),
          const CustomSizedBox(height: 67,),
          CustomElevatedButton(
            borderRadius: null,
            onPressed: () {
              Navigator.pushNamed(context, ScreenName.registerScreen,arguments: currentIndex==1?true:false,);
            },
            width: double.infinity,
            text: "اكمال التسجيل",
            height: 48,
          ),
        ],
      ).symmetricPadding(horizontal: 16),
    );
  }
}

class RegisterTypeButton extends StatelessWidget {
  final String iconPath;
  final String title;
  final bool isSelected;
  final void Function()? onPressed;

  const RegisterTypeButton({
    super.key,
    required this.iconPath,
    required this.title,
    required this.isSelected,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        backgroundColor:
            isSelected ? AppColors.primaryColor.withOpacity(0.1) : null,
        padding: EdgeInsets.symmetric(
          horizontal: 32.w,
          vertical: 16.h,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            height: 35.h,
            width: 35.w,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          const CustomSizedBox(
            height: 4,
          ),
          Text(
            title,
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          const CustomSizedBox(
            height: 4,
          ),
          CustomCheckBox(
            isChecked: isSelected,
            height: 19,
            width: 19,
            padding: 7,
          ),
        ],
      ),
    );
  }
}
