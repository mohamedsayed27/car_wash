import 'package:car_wash/presentation/widgets/shared_widgets/custom_divider.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';

class StepperWidget extends StatelessWidget {
  final int index;
  const StepperWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCheckBox(isChecked: index>0),
        const CustomSizedBox(width: 10,),
        Expanded(child: CustomDivider(color: index>1?AppColors.primaryColor:AppColors.greyColorD9,width: 2,),),
        const CustomSizedBox(width: 10,),
        CustomCheckBox(isChecked: index>=2,),
        const CustomSizedBox(width: 10,),
        Expanded(child: CustomDivider(color: index>2?AppColors.primaryColor:AppColors.greyColorD9,width: 2,),),
        const CustomSizedBox(width: 10,),
        CustomCheckBox(isChecked: index>=3),
      ],
    );
  }
}

class CustomCheckBox extends StatelessWidget {
  final bool isChecked;
  final double? width;
  final double? height;
  final double? padding;

  const CustomCheckBox({
    super.key,
    this.isChecked = false,
    this.width,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: width?.w ?? 24.w,
      height: height?.h ?? 24.h,
      decoration: BoxDecoration(
        color: isChecked ? AppColors.primaryColor : AppColors.greyColorB0,
        shape: BoxShape.circle,
      ),
      child: isChecked
          ? Center(
              child: Ink(
                height: 10.h,
                width: 10.w,
                decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  shape: BoxShape.circle,
                ),
              ),
            )
          : null,
    );
  }
}
