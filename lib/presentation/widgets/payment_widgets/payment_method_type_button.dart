import 'package:car_wash/presentation/widgets/shared_widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../shared_widgets/custom_check_box.dart';
import '../shared_widgets/custom_sized_box.dart';

class PaymentTypeMethodButton extends StatelessWidget {
  final bool isSelected;
  final void Function()? onPressed;
  final String svgPath;
  final String title;
  final Widget? child;

  const PaymentTypeMethodButton({
    super.key,
    required this.isSelected,
    this.onPressed,
    required this.svgPath,
    required this.title,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      borderColor: isSelected ? AppColors.primaryColor : AppColors.greyColorB0,
      backgroundColor: isSelected ? AppColors.primaryColor.withOpacity(0.08) : AppColors.whiteColor,
      borderRadius: 8,
      onPressed: onPressed,
      foregroundColor: AppColors.primaryColor,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      svgPath,
                      width: 40.w,
                      height: 40.h,
                      colorFilter: ColorFilter.mode(
                        isSelected
                            ? AppColors.primaryColor
                            : AppColors.greyColorB0,
                        BlendMode.srcIn,
                      ),
                    ),
                    CustomSizedBox(width: 16.w,),
                    Text(
                      title,
                      style: isSelected
                          ? CustomThemes.primaryColorTextTheme(context)
                              .copyWith(
                              fontSize: 16.sp,
                              fontWeight: CustomFontWeights.bold,
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
                width: 16,
              ),
              CustomCheckBox(
                isChecked: isSelected,
              ),
            ],
          ),
          child??const SizedBox.shrink(),
        ],
      ),
    );
  }
}
