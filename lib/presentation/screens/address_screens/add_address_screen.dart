import 'package:car_wash/core/parameters/address_parameters/add_address_parameters.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/address_google_map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../business_logic/address_cubit/address_cubit.dart';
import '../../../core/app_theme/app_colors.dart';
import '../../../core/constants/constants.dart';
import '../../widgets/shared_widgets/custom_app_bar.dart';
import '../../widgets/shared_widgets/custom_elevated_button.dart';
import '../../widgets/shared_widgets/custom_sized_box.dart';
import '../../widgets/shared_widgets/form_item_widget.dart';

class AddAddressScreen extends StatefulWidget {
  final String title;

  const AddAddressScreen({super.key, required this.title});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final TextEditingController streetNameController = TextEditingController();
  final TextEditingController buildingNumberNameController =
      TextEditingController();
  final TextEditingController floorNumberNameController =
      TextEditingController();
  final TextEditingController addressDetailsController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

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
            AddressGoogleMapWidget(
              onTap: (latLng) {
                AddressCubit.get(context).onMapTapped(latLng: latLng);
              },
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
              child: Form(
                key: formKey,
                child: ListView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
                  children: [
                    FormItemWidget(
                      title: "اسم الشارع",
                      hintText: "اسم الشارع",
                      controller: streetNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "برجاء ادخال البيانات";
                        }
                        return null;
                      },
                    ),
                    const CustomSizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: FormItemWidget(
                            title: "رقم المبنى",
                            hintText: "رقم المبنى",
                            controller: buildingNumberNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "برجاء ادخال البيانات";
                              }
                              return null;
                            },
                          ),
                        ),
                        const CustomSizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: FormItemWidget(
                            title: "الدور",
                            hintText: "الدور",
                            controller: floorNumberNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "برجاء ادخال البيانات";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const CustomSizedBox(
                      height: 16,
                    ),
                    FormItemWidget(
                      title: "اسم العنوان",
                      hintText: "اسم العنوان",
                      controller: addressDetailsController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "برجاء ادخال البيانات";
                        }
                        return null;
                      },
                    ),
                    const CustomSizedBox(
                      height: 16,
                    ),
                    BlocConsumer<AddressCubit, AddressState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        var cubit = AddressCubit.get(context);
                        return CustomElevatedButton(
                          onPressed: () {
                            if(formKey.currentState!.validate()){
                              if(cubit.currentLocation!=null) {
                                cubit.addAddress(
                                addAddressParameters: AddAddressParameters(
                                  streetName: streetNameController.text,
                                  buildingNo: buildingNumberNameController.text,
                                  floorNo: floorNumberNameController.text,
                                  addressType: addressDetailsController.text,
                                  lat: cubit.currentLocation!.latitude.toString(),
                                  long:
                                  cubit.currentLocation!.longitude.toString(),
                                ),
                              );
                              }else{

                                showToast(errorType: 0, message: "برجاء اختيار الموقع من الخريطة",);
                              }

                            }

                          },
                          text: "حفظ",
                          width: double.infinity,
                          height: 48,
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
