import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_router/screens_name.dart';
import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/assets_path/images_path.dart';
import '../../../core/constants/constants.dart';
import '../../widgets/shared_widgets/custom_app_bar.dart';
import '../../widgets/shared_widgets/custom_divider.dart';
import '../../widgets/shared_widgets/custom_sized_box.dart';

class AllChatsScreen extends StatelessWidget {
  const AllChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "الرسائل",
        ),
      ),
      body: ListView.separated(
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, ScreenName.chatScreen);
            },
            child: const ChatItemWidget(),
          );
        },
        separatorBuilder: (_, index) {
          return const Column(
            children: [
              CustomSizedBox(
                height: 8,
              ),
              CustomDivider(
                width: 0.5,
                color: AppColors.greyColorB0,
              ),
              CustomSizedBox(
                height: 8,
              ),
            ],
          );
        },
        itemCount: 5,
      ),
    );
  }
}

class ChatItemWidget extends StatelessWidget {
  const ChatItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 52.h,
          width: 52.w,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: Image.asset(
            ImagesPath.dummyPersonImage,
            fit: BoxFit.cover,
          ),
        ),
        const CustomSizedBox(
          width: 12,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            decoration: BoxDecoration(
              color: const Color(0xffFAFAFA),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "احمد محمد احمد",
                  style: CustomThemes.primaryColorTextTheme(context).copyWith(
                    fontSize: 16.sp,
                    fontWeight: CustomFontWeights.w500,
                  ),
                ),
                const CustomSizedBox(
                  height: 4,
                ),
                Text(
                  "السلام عليكم ...",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: CustomThemes.greyColor71TextTheme(context).copyWith(
                    fontSize: 14.sp,
                    fontWeight: CustomFontWeights.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
