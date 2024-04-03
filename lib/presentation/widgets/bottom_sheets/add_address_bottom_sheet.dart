import 'package:car_wash/core/constants/extensions.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_divider.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../shared_widgets/custom_elevated_button.dart';
import '../shared_widgets/form_item_widget.dart';
import 'bottom_sheet_header_bar.dart';

class AddAddressBottomSheet extends StatelessWidget {
  final String title;

  const AddAddressBottomSheet({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: ListView(

        children: [
          const CustomSizedBox(
            height: 16,
          ),
          BottomSheetHeaderBar(
            title: title,
          ),
          const CustomDivider(),
          const CustomSizedBox(
            height: 16,
          ),
           Container(
            height: 325.h,
            width: double.infinity,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: const GoogleMap(
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(23.61108120291162, 45.286281856525534),
                zoom: 11.5,
              ),
            ),
          ),
          const CustomSizedBox(
            height: 16,
          ),
          const FormItemWidget(
            title: "اسم الشارع",
            hintText: "نص تلقائي",
          ),
          const CustomSizedBox(
            height: 16,
          ),
          const Row(
            children: [
              Expanded(
                child: FormItemWidget(
                  title: "رقم المبنى",
                  hintText: "نص تلقائي",
                ),
              ),
              CustomSizedBox(
                width: 8,
              ),
              Expanded(
                child: FormItemWidget(
                  title: "الدور",
                  hintText: "نص تلقائي",
                ),
              ),
              CustomSizedBox(
                width: 8,
              ),
              Expanded(
                child: FormItemWidget(
                  title: "رقم الشقة",
                  hintText: "نص تلقائي",
                ),
              ),
            ],
          ),
          const CustomSizedBox(
            height: 16,
          ),
          const FormItemWidget(
            title: "اسم العنوان",
            hintText: "نص تلقائي",
          ),
          const CustomSizedBox(
            height: 16,
          ),
          CustomElevatedButton(
            onPressed: () {

            },
            text: "حفظ",
            width: double.infinity,
            height: 48,
          ),
        ],
      ).symmetricPadding(horizontal: 16),
    );
  }
}
