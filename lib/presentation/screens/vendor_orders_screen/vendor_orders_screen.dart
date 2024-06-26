import 'package:car_wash/core/assets_path/lottie_path.dart';
import 'package:car_wash/data/models/order_models/single_order_model.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../business_logic/representative_cubit/representative_cubit.dart';
import '../../../core/app_router/screens_name.dart';
import '../../../presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/constants/constants.dart';
import '../../widgets/shared_widgets/custom_app_bar.dart';
import '../../widgets/shared_widgets/custom_divider.dart';
import '../../widgets/shared_widgets/details_container.dart';

class VendorOrdersScreenArgs extends Equatable {
  final List<SingleOrderModel> orderList;
  final String title;

  const VendorOrdersScreenArgs({
    required this.orderList,
    required this.title,
  });

  @override
  List<Object?> get props => [
        orderList,
        title,
      ];
}

class VendorOrdersScreen extends StatelessWidget {
  final VendorOrdersScreenArgs vendorOrdersScreenArgs;

  const VendorOrdersScreen({
    super.key,
    required this.vendorOrdersScreenArgs,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: CustomAppBar(
          title: vendorOrdersScreenArgs.title,
        ),
      ),
      body: vendorOrdersScreenArgs.orderList.isNotEmpty?ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
        itemBuilder: (_, index) {
          return VendorOrderContainer(
            singleOrderModel: vendorOrdersScreenArgs.orderList[index],
          );
        },
        separatorBuilder: (_, index) {
          return const CustomSizedBox(
            height: 16,
          );
        },
        itemCount: vendorOrdersScreenArgs.orderList.length,
      ):Center(child:Lottie.asset(LottiePath.empty,height: 280.h,width: 280.w,frameRate: FrameRate.max,
      ),),
    );
  }
}

class VendorOrderContainer extends StatefulWidget {
  final SingleOrderModel singleOrderModel;

  const VendorOrderContainer({super.key, required this.singleOrderModel});

  @override
  State<VendorOrderContainer> createState() => _VendorOrderContainerState();
}

class _VendorOrderContainerState extends State<VendorOrderContainer> {
  late String orderTime;
  final format = DateFormat.MMMEd('ar');
  final format1 = DateFormat.jm('ar');

  @override
  void initState() {  
    orderTime = "${format.format(DateTime.parse("${widget.singleOrderModel.scheduleTime?.date} ${widget.singleOrderModel.scheduleTime?.time}"))} ${format1.format(DateTime.parse("${widget.singleOrderModel.scheduleTime?.date} ${widget.singleOrderModel.scheduleTime?.time}"))}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DetailsContainer(
      onTap: (){

        RepresentativeCubit.get(context).getSingleOrder(id: widget.singleOrderModel.id.toString());
        Navigator.pushReplacementNamed(
          context,
          ScreenName.vendorProgressOrderScreen,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "اسم العميل",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: CustomFontWeights.bold,
            ),
          ),
          const CustomSizedBox(
            height: 8,
          ),
          Text(
            widget.singleOrderModel.client?.name ?? "",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
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
            "حجم السيارة",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: CustomFontWeights.bold,
            ),
          ),
          const CustomSizedBox(
            height: 8,
          ),
          Text(
            widget.singleOrderModel.carType ?? "",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
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
            "نوع الخدمة",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: CustomFontWeights.bold,
            ),
          ),
          const CustomSizedBox(
            height: 8,
          ),
          Text(
            widget.singleOrderModel.service ?? "",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
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
            "الموعد",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: CustomFontWeights.bold,
            ),
          ),
          const CustomSizedBox(
            height: 8,
          ),
          Text(
            orderTime,
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
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
            "العنوان",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: CustomFontWeights.bold,
            ),
          ),
          const CustomSizedBox(
            height: 8,
          ),
          Text(
            widget.singleOrderModel.userAddress?.streetName ?? "",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
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
            widget.singleOrderModel.orderStatus ?? "",
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 14.sp,
              fontWeight: CustomFontWeights.w400,
            ),
          ),
        ],
      ),
    );
  }
}
