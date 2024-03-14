import 'package:car_wash/core/app_theme/app_colors.dart';
import 'package:car_wash/core/app_theme/custom_font_weights.dart';
import 'package:car_wash/core/app_theme/custom_themes.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_check_box.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_outlined_button.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CarTypeWidget extends StatelessWidget {
  final bool isSelected;
  final void Function()? onPressed;
  final String svgPath;
  final String title;
  final String description;

  const CarTypeWidget({
    super.key,
    required this.isSelected,
    this.onPressed,
    required this.svgPath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      borderColor: isSelected ? AppColors.primaryColor : AppColors.greyColorB0,
      borderRadius: 8,
      onPressed: onPressed,
      foregroundColor: AppColors.primaryColor,
      backgroundColor: isSelected ? AppColors.primaryColor.withOpacity(0.08) : AppColors.whiteColor,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: SvgPicture.asset(
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
                  ),
                  TextSpan(
                    text: "     $title",
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
                  TextSpan(
                    text: " $description",
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
          ),
          CustomSizedBox(width: 16,),
          CustomCheckBox(
            isChecked: isSelected,
          ),
        ],
      ),
    );
  }
}
