import 'package:car_wash/core/app_router/screens_name.dart';
import 'package:car_wash/core/constants/extensions.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_app_bar.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/constants/constants.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "الاشعارات",
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "يوجد 6 طلبات",
              style: CustomThemes.greyColor71TextTheme(context).copyWith(
                fontSize: 16.sp,
                fontWeight: CustomFontWeights.w600,
              ),
            ),
          ),
          const CustomSizedBox(height: 16,),
          Expanded(
            child: ListView.separated(
              itemBuilder: (_, index) {
                return InkWell(onTap: (){Navigator.pushNamed(context, ScreenName.vendorConfirmOrderScreen);},child: const NotificationWidget());
              },
              separatorBuilder: (_, index) {
                return const CustomSizedBox(height: 16,);
              },
              itemCount: 6,
            ),
          ),
        ],
      ).symmetricPadding(horizontal: 16,),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(bottom: 15.h),
      leading: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "احمد محمد احمد",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 24.sp,
              fontWeight: CustomFontWeights.w500,
            ),
          ),
          const CustomSizedBox(height: 4,),
          Text(
            "غسيل سيارة صغيرة",
            style: CustomThemes.greyColor71TextTheme(context).copyWith(
              fontSize: 14.sp,
              fontWeight: CustomFontWeights.w500,
            ),
          ),
        ],
      ),
      // title: ,
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "الأحد",
            style: CustomThemes.greyColor71TextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: CustomFontWeights.w500,
            ),
          ),
          const CustomSizedBox(height: 4,),
          Text(
            "09:00AM",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: CustomFontWeights.w500,
            ),
          ),
          const CustomSizedBox(height: 4,),
          Text(
            "19 نوفمبر",
            style: CustomThemes.greyColor71TextTheme(context).copyWith(
              fontSize: 14.sp,
              fontWeight: CustomFontWeights.w500,
            ),
          ),
        ],
      ),
      shape: UnderlineInputBorder(
          borderSide: BorderSide(
        color: const Color(0xffEFEFEF),
        width: 1.w,
      )),
    );
  }
}
