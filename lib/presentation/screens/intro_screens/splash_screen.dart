import 'dart:async';

import 'package:car_wash/core/app_router/screens_name.dart';
import 'package:car_wash/core/app_theme/app_colors.dart';
import 'package:car_wash/core/assets_path/images_path.dart';
import 'package:car_wash/core/assets_path/svg_path.dart';
import 'package:car_wash/core/cache_helper/cache_keys.dart';
import 'package:car_wash/core/cache_helper/shared_pref_methods.dart';
import 'package:car_wash/core/constants/constants.dart';
import 'package:car_wash/core/enums/user_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _loading();
    super.initState();
  }

  _loading() {
    token = CacheHelper.getData(key: CacheKeys.token);
    Timer(
      const Duration(seconds: 2),
      () {
        if(token!=null){
          if(userType == UserTypeEnum.representative.name) {
            Navigator.pushReplacementNamed(context, ScreenName.vendorHomeScreen);
          }else{
            Navigator.pushReplacementNamed(context, ScreenName.userHomeScreen);
          }
        }else {
          Navigator.pushReplacementNamed(context, ScreenName.loginScreen);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              height: 200.h,
              width: double.infinity,
              color: AppColors.whiteColor,
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: SvgPicture.asset(
              SvgPath.splashImage,
              height: 493.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            top: 157.h,
            child: Image.asset(
              ImagesPath.logo,
              width: 292.w,
              height: 86.h,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 46.h,
        color: AppColors.whiteColor,
      ),
    );
  }
}
