import 'package:car_wash/core/constants/extensions.dart';
import 'package:car_wash/presentation/widgets/car_services_widgets/car_services_check_button.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/assets_path/svg_path.dart';

class MainServicesComponent extends StatefulWidget {
  const MainServicesComponent({super.key});

  @override
  State<MainServicesComponent> createState() => _MainServicesComponentState();
}

class _MainServicesComponentState extends State<MainServicesComponent> {
  List<Map<String, dynamic>> itemsList = [
    {
      "svgPath": SvgPath.innerWash,
      "title": "غسيل داخلي",
      "price": "70 ريال",
    },
    {
      "svgPath": SvgPath.outerWash,
      "title": "غسيل خارجي",
      "price": "120 ريال",
    },
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "الخدمات الرئيسية",
          style: CustomThemes.primaryColorTextTheme(context).copyWith(
            fontSize: 16.sp,
            fontWeight: CustomFontWeights.bold,
          )
        ),
        const CustomSizedBox(height: 16,),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            return CarServicesCheckButton(
              isSelected: index == currentIndex,
              svgPath: itemsList[index]['svgPath'],
              title: itemsList[index]['title'],
              price: itemsList[index]['price'],
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
          itemCount: itemsList.length,
        ),
      ],
    ).symmetricPadding(horizontal: 16);
  }
}