import 'package:car_wash/core/app_theme/app_colors.dart';
import 'package:car_wash/core/constants/extensions.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_outlined_button.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';

class SelectDateComponent extends StatefulWidget {
  const SelectDateComponent({super.key});

  @override
  State<SelectDateComponent> createState() => _SelectDateComponentState();
}

class _SelectDateComponentState extends State<SelectDateComponent> {
  List<Map<String, dynamic>> datesList({int index = 0}) => [
        {
          "day": "السبت",
          "date": "October 1$index",
        },
        {
          "day": "الاحد",
          "date": "October 1$index",
        },
        {
          "day": "الاثنين",
          "date": "October 1$index",
        },
        {
          "day": "الثلاثاء",
          "date": "October 1$index",
        },
        {
          "day": "الاربعاء",
          "date": "October 1$index",
        },
        {
          "day": "الخميس",
          "date": "October 1$index",
        },
        {
          "day": "الجمعه",
          "date": "October 1$index",
        },
      ];

  int? currentIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "تحديد الموعد",
          style: CustomThemes.primaryColorTextTheme(context).copyWith(
            fontSize: 16.sp,
            fontWeight: CustomFontWeights.bold,
          ),
        ).symmetricPadding(horizontal: 16),const CustomSizedBox(
          height: 16,
        ),
        CustomSizedBox(
          height: 56,
          width: double.infinity,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              itemBuilder: (_, index) {
                return SelectDateButton(
                  day: datesList(index: index)[index]["day"],
                  date: datesList(index: index)[index]["date"],
                  isSelected: currentIndex == index,
                  onPressed: () {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                );
              },
              separatorBuilder: (_, index) {
                return const CustomSizedBox(width: 8,);
              },
              itemCount: datesList().length),
        ),
      ],
    );
  }
}

class SelectDateButton extends StatelessWidget {
  final String day;
  final String date;
  final bool isSelected;
  final void Function()? onPressed;

  const SelectDateButton({
    super.key,
    required this.day,
    required this.date,
    required this.isSelected,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      borderColor: isSelected ? AppColors.primaryColor : AppColors.greyColorB0,
      onPressed: onPressed,
      foregroundColor: AppColors.primaryColor,
      backgroundColor: isSelected ? AppColors.primaryColor.withOpacity(0.08) : AppColors.whiteColor,
      borderRadius: 8,
      padding: EdgeInsets.symmetric(
        horizontal: 11.w,
        vertical: 6.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            day,
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
          const CustomSizedBox(
            height: 8,
          ),
          Text(
            date,
            style: CustomThemes.greyColorB0TextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: CustomFontWeights.w500,
            ),
          ),
        ],
      ),
    );
  }
}
