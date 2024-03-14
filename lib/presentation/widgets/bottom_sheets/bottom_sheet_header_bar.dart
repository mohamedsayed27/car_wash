import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../shared_widgets/custom_sized_box.dart';

class BottomSheetHeaderBar extends StatelessWidget {
  final String title;
  const BottomSheetHeaderBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      toolbarHeight: 30,
      title: Text(
        title.tr(),
        textAlign: TextAlign.center,
        style: CustomThemes.primaryColorTextTheme(context).copyWith(
          fontSize: 16.sp,
          fontWeight: CustomFontWeights.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leading: const SizedBox.shrink(),
      actions: [
        CustomSizedBox(
          height: 20,
          width: 20,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: IconButton.styleFrom(
                padding: EdgeInsets.zero
            ),
            icon: Icon(
              Icons.clear,
              size: 18.r,
              color: AppColors.blackColor,
            ),
          ),
        ),
      ],
    );
  }
}
