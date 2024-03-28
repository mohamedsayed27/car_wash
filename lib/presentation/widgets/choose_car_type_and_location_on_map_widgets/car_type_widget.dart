import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../order_widgets/stepper_widget.dart';
import '../shared_widgets/cached_network_image_widget.dart';
import '../shared_widgets/custom_outlined_button.dart';
import '../shared_widgets/custom_sized_box.dart';

class CarTypeWidget extends StatelessWidget {
  final bool isSelected;
  final void Function()? onPressed;
  final String imagesPath;
  final String title;
  final String description;

  const CarTypeWidget({
    super.key,
    required this.isSelected,
    this.onPressed,
    required this.imagesPath,
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
      backgroundColor: isSelected
          ? AppColors.primaryColor.withOpacity(0.08)
          : AppColors.whiteColor,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: CachedNetworkImageWidget(
                      imagePath: imagesPath,
                      height: 40.h,
                      width: 40.w,
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
          const CustomSizedBox(
            width: 16,
          ),
          CustomCheckBox(
            isChecked: isSelected,
          ),
        ],
      ),
    );
  }
}
