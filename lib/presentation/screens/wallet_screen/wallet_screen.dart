import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../business_logic/address_cubit/address_cubit.dart';
import '../../../core/app_theme/app_colors.dart';
import '../../../core/constants/extensions.dart';
import '../../../business_logic/orders_cubit/orders_cubit.dart';
import '../../../business_logic/plans_cubit/plans_cubit.dart';
import '../../../core/app_router/screens_name.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/constants/constants.dart';
import '../../../core/parameters/orders_parameters/add_orders_parameters.dart';
import '../../../data/models/address_model/address_model.dart';
import '../../../main.dart';
import '../../widgets/car_services_widgets/main_services_component.dart';
import '../../widgets/choose_car_type_and_location_on_map_widgets/car_type_list.dart';
import '../../widgets/shared_widgets/custom_app_bar.dart';
import '../../widgets/shared_widgets/custom_drop_down_button.dart';
import '../../widgets/shared_widgets/custom_elevated_button.dart';
import '../../widgets/shared_widgets/custom_sized_box.dart';
import '../../widgets/shared_widgets/custom_text_button.dart';
import '../../widgets/shared_widgets/details_container.dart';
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
    if (PlansCubit.get(context).plansList.isEmpty) {
      PlansCubit.get(context).getAllPlans();
    }
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
          BlocConsumer<PlansCubit, PlansState>(
            listener: (context, state) {},
            builder: (context, state) {
              PlansCubit cubit = PlansCubit.get(context);
              return DetailsContainer(
                radius: 6,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14),
                child: cubit.getUserPlansLoading
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : PlansCubit.get(context)
                            .plansList
                            .any((element) => element.isSubscribed == 1)
                        ? Text(
                            "انت مشترك في باقة ${PlansCubit.get(context).plansList.firstWhere((element) => element.isSubscribed == 1).name} ولديك عدد ${PlansCubit.get(context).plansList.firstWhere((element) => element.isSubscribed == 1).washNumber} غسلة متبقي ",
                            style: CustomThemes.primaryColorTextTheme(context)
                                .copyWith(
                              fontSize: 16.sp,
                              fontWeight: CustomFontWeights.bold,
                            ),
                          )
                        : Text(
                            "انت لم تشترك في اي باقة",
                            style: CustomThemes.primaryColorTextTheme(context)
                                .copyWith(
                              fontSize: 16.sp,
                              fontWeight: CustomFontWeights.bold,
                            ),
                          ),
              );
            },
          ).symmetricPadding(horizontal: 16),
          const CustomSizedBox(
            height: 16,
          ),
          BlocBuilder<PlansCubit, PlansState>(
            builder: (context, state) {
              var cubit = PlansCubit.get(context);
              return Visibility(
                visible: cubit
                    .plansList
                    .any((element) => element.isSubscribed == 1),
                child: ExpansionTile(
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
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        "العنوان",
                        textAlign: TextAlign.start,
                        style: CustomThemes.primaryColorTextTheme(context)
                            .copyWith(
                          fontSize: 16.sp,
                          fontWeight: CustomFontWeights.bold,
                        ),
                      ),
                    ).symmetricPadding(horizontal: 16),
                    const CustomSizedBox(
                      height: 16,
                    ),
                    BlocConsumer<AddressCubit, AddressState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        var cubit = AddressCubit.get(context);
                        return cubit.getAddressLoading
                            ? const Center(
                                child: CircularProgressIndicator.adaptive(),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: cubit.getAddressesModel!.result !=
                                            null
                                        ? CustomDropDownButton<AddressModel>(
                                            items: cubit.getAddressesModel!
                                                        .result !=
                                                    null
                                                ? cubit
                                                    .getAddressesModel!.result!
                                                    .map(
                                                      (e) => DropdownMenuItem(
                                                        value: e,
                                                        child: Text(
                                                            e.streetName ?? ""),
                                                      ),
                                                    )
                                                    .toList()
                                                : [],
                                            value: cubit.addressModel,
                                            borderColor:
                                                cubit.addressModel == null
                                                    ? null
                                                    : AppColors.primaryColor,
                                            hintText: "اختر المكان",
                                            onChanged:
                                                cubit.chooseSelectedAddress,
                                          )
                                        : Text(
                                            "لم تقم باضافة عنوان",
                                            textAlign: TextAlign.start,
                                            style: CustomThemes
                                                    .greyColor71TextTheme(
                                                        context)
                                                .copyWith(
                                              fontSize: 14.sp,
                                              fontWeight:
                                                  CustomFontWeights.w500,
                                            ),
                                          ),
                                  ),
                                  const CustomSizedBox(
                                    width: 16,
                                  ),
                                  CustomTextButton(
                                    title: "اضافة عنوان",
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, ScreenName.addAddressScreen);
                                    },
                                    style: CustomThemes.primaryColorTextTheme(
                                            context)
                                        .copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ).symmetricPadding(horizontal: 16);
                      },
                    ),
                    const CustomSizedBox(
                      height: 16,
                    ),
                    const MainServicesComponent(),
                    const CustomSizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        "نوع السيارة",
                        textAlign: TextAlign.start,
                        style: CustomThemes.primaryColorTextTheme(context)
                            .copyWith(
                          fontSize: 16.sp,
                          fontWeight: CustomFontWeights.bold,
                        ),
                      ),
                    ).symmetricPadding(horizontal: 16),
                    const CustomSizedBox(
                      height: 16,
                    ),
                    const CarTypeList(
                      shrinkWrap: true,
                    ).symmetricPadding(horizontal: 16),
                    const CustomSizedBox(
                      height: 16,
                    ),
                    BlocConsumer<OrdersCubit, OrdersState>(
                      listener: (context, state) {
                        if (state is MakeOrderSuccessState) {
                          Navigator.pop(context);
                          showToast(
                            errorType: 0,
                            message: state.baseResponseModel.message ?? "",
                          );
                          navigatorKey = GlobalKey<NavigatorState>();
                          Phoenix.rebirth(context);

                        }
                        if (state is MakeOrderLoadingState) {
                          showProgressIndicator(context);
                        }
                        if (state is MakeOrderErrorState) {
                          Navigator.pop(context);
                          showToast(
                            errorType: 1,
                            message: state.error ?? "",
                          );
                        }
                      },
                      builder: (context, state) {
                        OrdersCubit cubit = OrdersCubit.get(context);
                        return CustomElevatedButton(
                          onPressed: () {
                            if (OrdersCubit.get(context).selectedTimeModel ==
                                null) {
                              showToast(
                                  errorType: 1,
                                  message: "يجب تحديد موعد الطلب");
                            } else if (OrdersCubit.get(context)
                                    .servicesCurrentIndex ==
                                null) {
                              showToast(
                                  errorType: 1,
                                  message: "يجب اختيار الخدمة اولا");
                            } else if (AddressCubit.get(context).addressModel ==
                                    null ||
                                OrdersCubit.get(context).carContentImageModel ==
                                    null) {
                              showToast(
                                errorType: 1,
                                message: "من فضلك بأختيار العنوان ونوع السيارة",
                              );
                            } else {
                              cubit.makeOrder(
                                addOrderParameters: AddOrderParameters(
                                  userPlanId: PlansCubit.get(context)
                                      .plansList
                                      .firstWhere((element) =>
                                          element.isSubscribed == 1)
                                      .userIdPlan
                                      .toString(),
                                  serviceId: OrdersCubit.get(context)
                                      .servicesContentImageModel
                                      ?.id
                                      ?.toString(),
                                  carTypeId: OrdersCubit.get(context)
                                      .carContentImageModel
                                      ?.id
                                      .toString(),
                                  userAddressId: AddressCubit.get(context)
                                      .addressModel!
                                      .id
                                      .toString(),
                                  orderTimeId: OrdersCubit.get(context)
                                      .selectedTimeModel
                                      ?.id
                                      .toString(),
                                ),
                              );
                            }
                          },
                          width: double.infinity,
                          text: "حجز",
                          height: 48,
                        );
                      },
                    ).symmetricPadding(horizontal: 16),
                    const CustomSizedBox(
                      height: 16,
                    ),
                  ],
                ),
              );
            },
          ),
          BlocConsumer<OrdersCubit, OrdersState>(
            listener: (context, state) {},
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
                          itemBuilder: (_, index) => ServiceTypeAndTimeWidget(
                            singleOrderModel:
                                cubit.getAllOrdersModel?.result?[index],
                            onTap: () {
                              cubit.getSingleOrder(
                                  id: cubit.getAllOrdersModel?.result?[index]
                                          .id ??
                                      0);
                              Navigator.pushNamed(
                                context,
                                ScreenName.userOrderProgressScreen,
                              );
                            },
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              cubit.getAllOrdersModel?.result?.length ?? 0,
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
