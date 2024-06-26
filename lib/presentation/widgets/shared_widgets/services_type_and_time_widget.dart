import 'package:car_wash/data/models/order_models/single_order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import 'custom_divider.dart';
import 'custom_sized_box.dart';
import 'details_container.dart';

class ServiceTypeAndTimeWidget extends StatefulWidget {
  final SingleOrderModel? singleOrderModel;
  final void Function()? onTap;
  const ServiceTypeAndTimeWidget({super.key, this.singleOrderModel, this.onTap,});

  @override
  State<ServiceTypeAndTimeWidget> createState() => _ServiceTypeAndTimeWidgetState();
}

class _ServiceTypeAndTimeWidgetState extends State<ServiceTypeAndTimeWidget> {
  late String orderTime;
  final format = DateFormat.MMMEd('ar');
  final format1 = DateFormat.jm('ar');

  @override
  void initState() {
    orderTime = widget.singleOrderModel!=null?"${format.format(DateTime.parse("${widget.singleOrderModel?.scheduleTime?.date} ${widget.singleOrderModel?.scheduleTime?.time}"))} ${format1.format(DateTime.parse("${widget.singleOrderModel?.scheduleTime?.date} ${widget.singleOrderModel?.scheduleTime?.time}"))}":"";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DetailsContainer(
      onTap: widget.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "الخدمة",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: CustomFontWeights.bold,
            ),
          ),
          const CustomSizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.singleOrderModel?.service??"",
                style:
                CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 14.sp,
                  fontWeight: CustomFontWeights.w400,
                ),
              ),
              Text(
                "${widget.singleOrderModel?.total??""} ريال",
                style:
                CustomThemes.primaryColorTextTheme(context).copyWith(
                  fontSize: 14.sp,
                  fontWeight: CustomFontWeights.w400,
                ),
              ),
            ],
          ),
          const CustomSizedBox(
            height: 8,
          ),
          const CustomDivider(),
          const CustomSizedBox(
            height: 8,
          ),
          Text(
            "المواعيد",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: CustomFontWeights.bold,
            ),
          ),
          const CustomSizedBox(
            height: 8,
          ),

          Text(
            widget.singleOrderModel!=null?orderTime:"",
            style:
            CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 14.sp,
              fontWeight: CustomFontWeights.w400,
            ),
          ),
          const CustomSizedBox(
            height: 8,
          ),
          const CustomDivider(),
          const CustomSizedBox(
            height: 8,
          ),
          Text(
            "حالة الطلب",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: CustomFontWeights.bold,
            ),
          ),
          const CustomSizedBox(
            height: 8,
          ),

          Text(
            widget.singleOrderModel?.orderStatus??"",
            style:
            CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 14.sp,
              fontWeight: CustomFontWeights.w400,
            ),
          ),
        ],
      ),
    );
  }
}
