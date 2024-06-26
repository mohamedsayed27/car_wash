import 'package:car_wash/business_logic/orders_cubit/orders_cubit.dart';
import 'package:car_wash/core/constants/extensions.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/details_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_router/screens_name.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/constants/constants.dart';
import '../../widgets/shared_widgets/custom_app_bar.dart';
import '../../widgets/shared_widgets/custom_elevated_button.dart';
import '../../widgets/shared_widgets/custom_sized_box.dart';
import '../../widgets/shared_widgets/select_date_component.dart';
import '../../widgets/shared_widgets/select_time_component.dart';
import '../../widgets/shared_widgets/services_type_and_time_widget.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    OrdersCubit.get(context).getAllOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "المحفظة",
        ),
      ),
      body: ListView(
        children: [
          DetailsContainer(
            radius: 6,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "انت مشترك بخدمة 5 غسلات شهريا",
                  style: CustomThemes.primaryColorTextTheme(context).copyWith(
                    fontSize: 16.sp,
                    fontWeight: CustomFontWeights.bold,
                  ),
                ),
                const CustomSizedBox(
                  height: 8,
                ),
                Text(
                  "متبقي لك 3 غسلات",
                  style: CustomThemes.primaryColorTextTheme(context).copyWith(
                    fontSize: 14.sp,
                    fontWeight: CustomFontWeights.w400,
                  ),
                ),
              ],
            ),
          ).symmetricPadding(horizontal: 16),
          const CustomSizedBox(
            height: 16,
          ),
          ExpansionTile(
            title: Text(
              "الطلبات القادمة",
              style: CustomThemes.primaryColorTextTheme(context).copyWith(
                fontSize: 16.sp,
                fontWeight: CustomFontWeights.bold,
              ),
            ),
            children: [
              const SelectDateComponent(),
              const CustomSizedBox(
                height: 24,
              ),
              const SelectTimeComponent(),
              const CustomSizedBox(
                height: 16,
              ),
              CustomElevatedButton(
                onPressed: () {},
                width: double.infinity,
                text: "حجز",
                height: 48,
              ).symmetricPadding(horizontal: 16),
              const CustomSizedBox(
                height: 16,
              ),
            ],
          ),
          BlocConsumer<OrdersCubit, OrdersState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              OrdersCubit cubit = OrdersCubit.get(context);
              return ExpansionTile(
                title: Text(
                  "الطلبات السابقة",
                  style: CustomThemes.primaryColorTextTheme(context).copyWith(
                    fontSize: 16.sp,
                    fontWeight: CustomFontWeights.bold,
                  ),
                ),
                children: [
                  cubit.getAllOrdersLoading
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                          separatorBuilder: (_, index) => const CustomSizedBox(
                            height: 16,
                          ),
                          itemBuilder: (_, index) => ServiceTypeAndTimeWidget(singleOrderModel: cubit.getAllOrdersModel?.result?[index],onTap: (){
                            cubit.getSingleOrder(id: cubit.getAllOrdersModel?.result?[index].id??0);
                            Navigator.pushNamed(context,
                                ScreenName.userOrderProgressScreen,);
                          },),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cubit.getAllOrdersModel?.result?.length??0,
                        ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
