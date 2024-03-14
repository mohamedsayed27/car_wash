import 'package:car_wash/core/app_router/screens_name.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/constants/constants.dart';
import '../../widgets/shared_widgets/custom_elevated_button.dart';
import '../../widgets/shared_widgets/custom_sized_box.dart';

class VendorInProgressOrderScreen extends StatefulWidget {
  const VendorInProgressOrderScreen({super.key});

  @override
  State<VendorInProgressOrderScreen> createState() => _VendorInProgressOrderScreenState();
}

class _VendorInProgressOrderScreenState extends State<VendorInProgressOrderScreen> {
  bool isStarted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(preferredSize: preferredSize, child: CustomAppBar(title: "طلب جاري",),),
      body: CustomSizedBox(
        height: double.infinity,
        width: double.infinity,
        child: GoogleMap(
          myLocationButtonEnabled: false,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(23.61108120291162, 45.286281856525534),
            zoom: 11.5,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 38.w,vertical: 38.h,),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -2.h),
              blurRadius: 12.r,
              color: AppColors.shadowColor(value: 0.15),
            )
          ],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.r),
            topLeft: Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isStarted?"تم بدء الطلب":"توقيت البدء",
                  style: CustomThemes.primaryColorTextTheme(context).copyWith(
                    fontSize: 16.sp,
                    fontWeight: CustomFontWeights.bold,
                  ),
                ),
                Text(
                  "9:00",
                  style: CustomThemes.primaryColorTextTheme(context).copyWith(
                    fontSize: 16.sp,
                    fontWeight: CustomFontWeights.bold,
                  ),
                ),
              ],
            ),
            const CustomSizedBox(
              height: 16,
            ),
            CustomElevatedButton(
              onPressed: (){
                if(isStarted==false){
                  isStarted = true;
                  setState(() {

                  });

                }
                else{
                  Navigator.pushNamedAndRemoveUntil(context, ScreenName.vendorHomeScreen, (route) => false).then((value) {
                    isStarted = false;
                  });
                }
              },
              text: isStarted?"انهاء الطلب":"بدء الطلب",
              height: 48,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
