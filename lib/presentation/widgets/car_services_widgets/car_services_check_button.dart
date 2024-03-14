import 'package:car_wash/core/app_theme/app_colors.dart';
import 'package:car_wash/core/app_theme/custom_font_weights.dart';
import 'package:car_wash/core/app_theme/custom_themes.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_check_box.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_outlined_button.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CarServicesCheckButton extends StatelessWidget {
  final bool isSelected;
  final void Function()? onPressed;
  final String svgPath;
  final String title;
  final String price;

  const CarServicesCheckButton({
    super.key,
    required this.isSelected,
    this.onPressed,
    required this.svgPath,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      borderColor: isSelected ? AppColors.primaryColor : AppColors.greyColorB0,
      borderRadius: 8,
      onPressed: onPressed,
      backgroundColor: isSelected ? AppColors.primaryColor.withOpacity(0.08) : AppColors.whiteColor,
      foregroundColor: AppColors.primaryColor,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                SvgPicture.asset(
                  svgPath,
                  width: 40.w,
                  height: 40.h,
                  colorFilter: ColorFilter.mode(
                    isSelected ? AppColors.primaryColor : AppColors.greyColorB0,
                    BlendMode.srcIn,
                  ),
                ),
                const CustomSizedBox(
                  width: 16,
                ),
                Text(
                  title,
                  style: isSelected
                      ? CustomThemes.primaryColorTextTheme(context).copyWith(
                          fontSize: 16.sp,
                          fontWeight: CustomFontWeights.bold,
                        )
                      : CustomThemes.greyColorB0TextTheme(context).copyWith(
                          fontSize: 16.sp,
                          fontWeight: CustomFontWeights.w500,
                        ),
                ),
                const Spacer(),
                Text(
                  price,
                  style: isSelected
                      ? CustomThemes.primaryColorTextTheme(context).copyWith(
                          fontSize: 16.sp,
                          fontWeight: CustomFontWeights.w500,
                        )
                      : CustomThemes.greyColorB0TextTheme(context).copyWith(
                          fontSize: 16.sp,
                          fontWeight: CustomFontWeights.w500,
                        ),
                ),
              ],
            ),
          ),
          const CustomSizedBox(
            width: 8,
          ),
          CustomCheckBox(
            isChecked: isSelected,
          ),
        ],
      ),
    );
  }
}
