import 'package:car_wash/core/app_theme/custom_font_weights.dart';
import 'package:car_wash/core/app_theme/custom_themes.dart';
import 'package:car_wash/core/assets_path/svg_path.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_app_bar.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/assets_path/images_path.dart';
import '../../../core/constants/constants.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "من نحن",
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
        children: [
          CustomSizedBox(height: 238,width: double.infinity,child: Image.asset(ImagesPath.aboutUsDummy,fit: BoxFit.cover,),),
          CustomSizedBox(height: 16,),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "هذا النص هو مثال لنص يمكن أن يستبدل",
                    style: CustomThemes.primaryColorTextTheme(context).copyWith(
                      fontSize: 18.sp,
                      fontWeight: CustomFontWeights.bold,
                    ),
                  ),
                  const CustomSizedBox(height: 8,),
                  Text(
                    "في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.إذا كنت تحتاج إلى عدد أكبر من الفقرات يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد، النص لن يبدو مقسما ولا يحوي أخطاء لغوية، مولد النص العربى مفيد لمصممي المواقع على وجه الخصوص، حيث يحتاج العميل فى كثير من الأحيان أن يطلع على صورة حقيقية لتصميم الموقع.ومن هنا وجب على المصمم أن يضع نصوصا مؤقتة على التصميم ليظهر للعميل الشكل كاملاً،",
                    style: CustomThemes.primaryColorTextTheme(context).copyWith(
                        fontSize: 16.sp,
                        fontWeight: CustomFontWeights.w400,
                        height: 1.5.h
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (_, index) {
              return const CustomSizedBox(
                height: 24,
              );
            },
            itemCount: 4,
          ),
        ],
      ),
    );
  }
}
