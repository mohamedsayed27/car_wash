import 'package:car_wash/core/app_theme/app_colors.dart';
import 'package:car_wash/core/app_theme/custom_font_weights.dart';
import 'package:car_wash/core/app_theme/custom_themes.dart';
import 'package:car_wash/core/assets_path/images_path.dart';
import 'package:car_wash/core/assets_path/svg_path.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_app_bar.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_divider.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/constants.dart';
import '../../widgets/profile_widgets/intro_data_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: CustomAppBar(
          title: "الحساب الشخصي",
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          IntroDetailsWidget(),
          CustomSizedBox(height: 16,),
          ProfileListTileItemWidget(svgPath: SvgPath.wallet, title: 'المحفظة',onPressed: (){},),
          ProfileListTileItemWidget(svgPath: SvgPath.messageQuestion, title: 'من نحن',onPressed: (){},),
          ProfileListTileItemWidget(svgPath: SvgPath.profileMessage, title: 'المساعدة',onPressed: (){},),
          ProfileListTileItemWidget(svgPath: SvgPath.infoCircle, title: 'الشروط والاحكام',onPressed: (){},),
        ],
      ),
    );
  }
}

class ProfileListTileItemWidget extends StatelessWidget {
  final String svgPath;
  final String title;
  final void Function()? onPressed;
  final Color? borderColor;
  const ProfileListTileItemWidget({
    super.key,
    required this.svgPath,
    required this.title,
    this.onPressed, this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset(
        svgPath,
        height: 24.h,
        width: 24.w,
        colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn,),
      ),
      title: Text(
        "محمود سالم",
        style: CustomThemes.primaryColorTextTheme(context).copyWith(
          fontSize: 16.sp,
          fontWeight: CustomFontWeights.bold,
        ),
      ),
      onTap: onPressed,
      shape: UnderlineInputBorder(
        borderSide: BorderSide(
          color: borderColor??AppColors.greyColorB0,
          width: 0.5.w,
        ),
      ),
    );
  }
}
