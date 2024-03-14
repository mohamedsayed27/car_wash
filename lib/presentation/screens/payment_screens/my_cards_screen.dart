import 'package:car_wash/core/assets_path/svg_path.dart';
import 'package:car_wash/presentation/widgets/bottom_sheets/add_card_bottom_sheet.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/constants/constants.dart';
import '../../widgets/shared_widgets/custom_app_bar.dart';
import '../../widgets/shared_widgets/custom_check_box.dart';
import '../../widgets/shared_widgets/custom_elevated_button.dart';
import '../../widgets/shared_widgets/custom_outlined_button.dart';

class MyCardsScreen extends StatelessWidget {
  const MyCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "طرق الدفع",
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 32.h,
        ),
        children: [
          const ChooseCardComponent(),
          const CustomSizedBox(
            height: 16,
          ),
          CustomOutlinedButton(
            borderColor: AppColors.greyColorB0,
            backgroundColor: AppColors.whiteColor,
            borderRadius: 8,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) {
                  return const CardBottomSheet();
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
                  "اضافة بطاقة",
                  style: CustomThemes.greyColorB0TextTheme(context).copyWith(
                    fontSize: 14.sp,
                    fontWeight: CustomFontWeights.bold,
                  ),
                ),
              ],
            ),
          ),
          const CustomSizedBox(
            height: 32,
          ),
          CustomElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            width: double.infinity,
            text: "الرجوع",
            height: 48,
          ),
        ],
      ),
    );
  }
}

class ChooseCardComponent extends StatefulWidget {
  const ChooseCardComponent({super.key});

  @override
  State<ChooseCardComponent> createState() => _ChooseCardComponentState();
}

class _ChooseCardComponentState extends State<ChooseCardComponent> {
  List<Map<String, dynamic>> itemsList = [
    {
      "number": "2153 **** **** ****",
      "svgPath": SvgPath.visa,
    },
    {
      "number": "1234 **** **** ****",
      "svgPath": SvgPath.masterCard,
    },
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (_, index) {
        return CustomOutlinedButton(
          borderColor: currentIndex == index
              ? AppColors.primaryColor
              : AppColors.greyColorB0,
          backgroundColor: currentIndex == index
              ? AppColors.primaryColor.withOpacity(0.08)
              : AppColors.whiteColor,
          borderRadius: 8,
          onPressed: () {
            setState(() {
              currentIndex = index;
            });
          },
          foregroundColor: AppColors.primaryColor,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      itemsList[index]["svgPath"],
                      width: 20.w,
                      height: index == 0 ? 12.h : 18.h,
                    ),
                    CustomSizedBox(
                      width: 16.w,
                    ),
                    Text(
                      itemsList[index]["number"],
                      style: currentIndex == index
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
                isChecked: currentIndex == index,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, index) {
        return const CustomSizedBox(
          height: 8,
        );
      },
      itemCount: itemsList.length,
    );
  }
}
