import 'package:car_wash/business_logic/orders_cubit/orders_cubit.dart';
import 'package:car_wash/presentation/screens/car_services_screen/car_services_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../business_logic/address_cubit/address_cubit.dart';
import '../../../core/app_router/screens_name.dart';
import '../../../core/app_theme/app_colors.dart';
import '../../../core/assets_path/images_path.dart';
import '../../../core/assets_path/svg_path.dart';
import '../../../core/constants/constants.dart';
import '../../../data/models/address_model/address_model.dart';
import '../../widgets/choose_car_type_and_location_on_map_widgets/car_type_list.dart';
import '../../widgets/drawers/drawer_button.dart';
import '../../widgets/shared_widgets/custom_drop_down_button.dart';
import '../../widgets/shared_widgets/custom_elevated_button.dart';
import '../../widgets/shared_widgets/custom_sized_box.dart';
import '../vendor_home_screen/vendor_home_screen.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    AddressCubit.get(context).getCurrentMarker();
    AddressCubit.get(context).getCurrentLocation();
    AddressCubit.get(context).getAddress();
    super.initState();
  }

  List<String> itemsList = [
    "data1",
    "data2",
    "data3",
    "data4",
    "data5",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Image.asset(
                ImagesPath.loginLogo,
                width: 96.w,
                height: 94.h,
              ),
            ),
            CustomDrawerButton(
              iconPath: SvgPath.personOutlined,
              title: "حسابى",
              onPressed: () {
                Navigator.pushNamed(context, ScreenName.editProfileScreen);
              },
            ),
            CustomDrawerButton(
              iconPath: SvgPath.messageText,
              title: "الرسائل",
              onPressed: () {
                Navigator.pushNamed(context, ScreenName.allChatsScreen);
              },
            ),
            CustomDrawerButton(
              iconPath: SvgPath.myOrders,
              title: "طلباتى",
              onPressed: () {
                Navigator.pushNamed(context, ScreenName.walletScreen);
              },
            ),
            const CustomSizedBox(
              height: 128,
            ),
            CustomDrawerButton(
              iconPath: SvgPath.myOrders,
              title: "طلباتى",
              onPressed: () {},
            ),
            // Add more items as needed
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BlocConsumer<AddressCubit, AddressState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = AddressCubit.get(context);
              return cubit.getCurrentLocationLoading
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : CustomSizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: GoogleMap(
                        myLocationButtonEnabled: false,
                        onCameraMove: (CameraPosition cameraPosition) {
                          setState(() {
                            cubit.zoomValue = cameraPosition.zoom;
                          });
                        },
                        onMapCreated: (controller) {
                          cubit.googleMapController.complete(controller);
                        },
                        markers: cubit.markers,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            cubit.currentLocation!.latitude,
                            cubit.currentLocation!.longitude,
                          ),
                          zoom: cubit.zoomValue,
                        ),
                        mapType: MapType.normal,
                      ),
                    );
            },
          ),
          PositionedDirectional(
            top: preferredSize.height,
            start: 16,
            end: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomIconButton(
                  assetName: SvgPath.menuDrawer,
                  isNotification: false,
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                ),
                const SizedBox(),
                // CustomIconButton(
                //   assetName: SvgPath.notification,
                //   isNotification: true,
                //   onPressed: () {
                //
                //     Navigator.pushNamed(context, ScreenName.notificationScreen);
                //   },
                // ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 48.w,
              vertical: 32.h,
            ),
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
                topRight: Radius.circular(16.r),
                topLeft: Radius.circular(16.r),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocConsumer<AddressCubit, AddressState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    var cubit = AddressCubit.get(context);
                    return cubit.getAddressLoading
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : CustomDropDownButton<AddressModel>(
                            items: cubit.getAddressesModel!.result!
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.streetName ?? ""),
                                  ),
                                )
                                .toList(),
                            value: cubit.addressModel,
                            borderColor: cubit.addressModel == null
                                ? null
                                : AppColors.primaryColor,
                            hintText: "اختر المكان",
                            onChanged: cubit.chooseSelectedAddress,
                          );
                  },
                ),
                const CustomSizedBox(
                  height: 18,
                ),
                const CarTypeList(),
                const CustomSizedBox(
                  height: 16,
                ),
                CustomElevatedButton(
                  onPressed: () {
                    if (AddressCubit.get(context).addressModel != null &&
                        OrdersCubit.get(context).carContentImageModel != null) {
                      Navigator.pushNamed(
                        context,
                        ScreenName.carServicesScreen,
                        arguments: CarServicesArgument(
                          addressId: AddressCubit.get(context)
                              .addressModel!
                              .id!
                              .toString(),
                          contentImageModel:
                              OrdersCubit.get(context).carContentImageModel,
                        ),
                      );
                    } else {
                      showToast(
                          errorType: 1,
                          message: "من فضلك بأختيار العنوان ونوع السيارة");
                    }
                  },
                  width: double.infinity,
                  text: "التالي",
                  height: 48,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
