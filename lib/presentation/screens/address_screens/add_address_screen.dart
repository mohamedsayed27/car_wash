import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/constants/constants.dart';
import '../../widgets/shared_widgets/custom_app_bar.dart';
import '../../widgets/shared_widgets/custom_elevated_button.dart';
import '../../widgets/shared_widgets/custom_sized_box.dart';
import '../../widgets/shared_widgets/form_item_widget.dart';

class AddAddressScreen extends StatelessWidget {
  final String title;

  const AddAddressScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "اضافة عنوان",
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: GoogleMap(
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(23.61108120291162, 45.286281856525534,),
                zoom: 11.5,
              ),
            ),
          ),
          Container(
            height: 380.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -1.h),
                  blurRadius: 16.r,
                  color: AppColors.shadowColor(value: 0.1),
                )
              ],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(32.r),
                topLeft: Radius.circular(32.r),
              ),
            ),
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 32.h),
              children: [
                const FormItemWidget(
                  title: "اسم الشارع",
                  hintText: "اسم الشارع",
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                const Row(
                  children: [
                    Expanded(
                      child: FormItemWidget(
                        title: "رقم المبنى",
                        hintText: "رقم المبنى",
                      ),
                    ),
                    CustomSizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: FormItemWidget(
                        title: "الدور",
                        hintText: "الدور",
                      ),
                    ),
                    CustomSizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: FormItemWidget(
                        title: "رقم الشقة",
                        hintText: "رقم الشقة",
                      ),
                    ),
                  ],
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                const FormItemWidget(
                  title: "اسم العنوان",
                  hintText: "اسم العنوان",
                ),
                const CustomSizedBox(
                  height: 16,
                ),
                CustomElevatedButton(
                  onPressed: () {},
                  text: "حفظ",
                  width: double.infinity,
                  height: 48,
                ),
              ],
            ),
          )
        ],
      )

    );
  }
}
