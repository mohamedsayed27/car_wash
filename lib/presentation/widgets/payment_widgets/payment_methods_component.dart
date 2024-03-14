import 'package:car_wash/core/app_theme/custom_font_weights.dart';
import 'package:car_wash/core/app_theme/custom_themes.dart';
import 'package:car_wash/core/assets_path/svg_path.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_router/screens_name.dart';
import '../../../core/app_theme/app_colors.dart';
import '../../widgets/payment_widgets/payment_method_type_button.dart';
import '../../widgets/shared_widgets/custom_text_button.dart';

class PaymentMethodsComponent extends StatefulWidget {
  const PaymentMethodsComponent({super.key});

  @override
  State<PaymentMethodsComponent> createState() => _PaymentMethodsComponentState();
}

class _PaymentMethodsComponentState extends State<PaymentMethodsComponent> {
  List<Map<String, dynamic>> itemsList(context, {bool isSelected = false}) => [
    {
      "svgPath": SvgPath.creditCard,
      "title": "بطاقة ائتمان",
      "child": Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "رقم البطاقة",
            style: CustomThemes.greyColorB0TextTheme(context).copyWith(
              fontSize: 14.sp,
              fontWeight: CustomFontWeights.w300,
            ),
          ),
          const CustomSizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "2153 **** **** ****",
                style: isSelected
                    ? CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 14.sp,
                  fontWeight: CustomFontWeights.bold,
                )
                    : CustomThemes.greyColorB0TextTheme(context).copyWith(
                  fontSize: 14.sp,
                  fontWeight: CustomFontWeights.w500,
                ),
              ),
              CustomTextButton(
                height: 23,
                onPressed: isSelected?() {
                  Navigator.pushNamed(context, ScreenName.myCardsScreen);
                }:null,
                child: Text(
                  "تغيير",
                  style:isSelected
                      ? CustomThemes.primaryColorTextTheme(context).copyWith(
                    fontWeight: CustomFontWeights.bold,
                    fontSize: 14.sp,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primaryColor,
                  )
                      : CustomThemes.greyColorB0TextTheme(context).copyWith(
                    fontWeight: CustomFontWeights.w500,
                    fontSize: 14.sp,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.greyColorB0,
                  ),

                ),
              ),
            ],
          ),
        ],
      ),
    },
    {
      "svgPath": SvgPath.wallet,
      "title": "المحفظة",
      "child": null,
    },
    {
      "svgPath": SvgPath.money,
      "title": "كاش",
      "child": null,
    },
    {
      "svgPath": SvgPath.applePay,
      "title": "آبل باي",
      "child": null,
    },
  ];

  int? currentIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return PaymentTypeMethodButton(
          isSelected: currentIndex == index,
          svgPath:
          itemsList(context, isSelected: currentIndex == index)[index]
          ["svgPath"],
          title:
          itemsList(context, isSelected: currentIndex == index)[index]
          ["title"],
          child:
          itemsList(context, isSelected: currentIndex == index)[index]
          ["child"],
          onPressed: () {
            setState(() {
              currentIndex = index;
            });
          },
        );
      },
      separatorBuilder: (_, index) {
        return const CustomSizedBox(
          height: 8,
        );
      },
      itemCount: itemsList(
        context,
      ).length,
    );
  }
}
