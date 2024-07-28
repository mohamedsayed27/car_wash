import 'dart:async';

import 'package:car_wash/business_logic/auth_cubit/auth_cubit.dart';
import 'package:car_wash/core/cache_helper/shared_pref_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/app_router/screens_name.dart';
import '../../../core/app_theme/app_colors.dart';
import '../../../core/assets_path/svg_path.dart';
import '../../../core/constants/extensions.dart';
import '../../../presentation/widgets/shared_widgets/custom_sized_box.dart';
import '../../../core/assets_path/images_path.dart';
import '../../../core/constants/constants.dart';
import '../../../core/google_map/google_map_services.dart';
import '../../widgets/drawers/drawer_button.dart';

class VendorHomeScreen extends StatefulWidget {
  const VendorHomeScreen({super.key});

  @override
  State<VendorHomeScreen> createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends State<VendorHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Completer<GoogleMapController> _googleMapController =
      Completer<GoogleMapController>();
  late final LatLng sourceLocation;

  final GoogleMapsServices googleMapsServices = GoogleMapsServices();
  List<LatLng> polyLineCoordinates = [];

  // void getPolyLinePoints(Position? currentLocation) async {
  //   print("object");
  //   PolylinePoints polylinePoints = PolylinePoints();
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //       "AIzaSyCAOMyuhbP1CAJ1H4WnnMSXyC_xhpu72tE",
  //       PointLatLng(currentLocation!.latitude, currentLocation.longitude),
  //       PointLatLng(widget.destinationLocation.latitude, widget.destinationLocation.longitude));
  //   if (result.points.isNotEmpty) {
  //     for (var element in result.points) {
  //       polyLineCoordinates.add(LatLng(element.latitude, element.longitude));
  //       print(element);
  //     }
  //   }
  //   setState(() {});
  // }
  BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;
  Position? currentLocation;

  void getCurrentMarker() {
    BitmapDescriptor.asset(
      ImageConfiguration.empty,
      ImagesPath.locationOnMap,
      height: 32.h,
      width: 32.w,
    ).then((value) {
      currentIcon = value;
    });
    setState(() {});
  }

  bool getCurrentLocationLoading = false;
  void getCurrentLocation() async {
    getCurrentLocationLoading = true;
    setState(() {

    });
    googleMapsServices.getGeoLocationPosition().then((value) {
      currentLocation = value;
      sourceLocation =
          LatLng(currentLocation!.latitude, currentLocation!.longitude);

      getCurrentLocationLoading = false;
      setState(() {

      });
      // getPolyLinePoints(currentLocation);
    }).catchError((error) {
    });
    GoogleMapController controller = await _googleMapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            currentLocation!.latitude,
            currentLocation!.longitude,
          ),
          zoom: zoomValue,
        ),
      ),
    );
    // addMarker(currentLocation!);

    getCurrentLocationLoading = false;
    setState(() {

    });
  }

  double zoomValue = 13.5;

  @override
  void initState() {
    getCurrentMarker();
    getCurrentLocation();
    super.initState();
  }



  // void closestNumbers(List<int> numbers) {
  //   numbers.sort();
  //   int minDiff = numbers[1] - numbers[0];
  //   List<Map<String, int>> itemsList = [];
  //   for (int i = 1; i < numbers.length; i++) {
  //     int diff = numbers[i] - numbers[i - 1];
  //     if(diff==minDiff){
  //       itemsList.add({
  //         "fistNum":numbers[i],
  //         "secondNum":numbers[i-1],
  //         "value": diff
  //       });
  //     }
  //     else if (diff < minDiff) {
  //       itemsList.removeWhere((element) => element.containsValue(minDiff));
  //       itemsList.add({
  //         "fistNum":numbers[i],
  //         "secondNum":numbers[i-1],
  //         "value": diff
  //       });
  //       minDiff = diff;
  //     }
  //   }
  //   itemsList.forEach((element){
  //     print("${element["secondNum"]} ${element["fistNum"]}");
  //   });
  // }

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
            // CustomDrawerButton(
            //   iconPath: SvgPath.home,
            //   title: "الرئيسية",
            //   onPressed: () {},
            // ),
            CustomDrawerButton(
              iconPath: SvgPath.personOutlined,
              title: "حسابى",
              onPressed: () {
                Navigator.pushNamed(context, ScreenName.vendorProfileScreen);
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
                Navigator.pushNamed(context, ScreenName.vendorOrdersStatisticsScreen);
              },
            ),
            const CustomSizedBox(
              height: 128,
            ),
            CustomDrawerButton(
              iconPath: SvgPath.logout,
              title: "تسجيل الخروج",
              onPressed: () {
                showProgressIndicator(context);
                CacheHelper.clearAllCache().then((v){
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    ScreenName.loginScreen,
                        (route) => false,
                  );
                });
              },
            ),
            // Add more items as needed
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          getCurrentLocationLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : CustomSizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: GoogleMap(
                    myLocationButtonEnabled: false,
                    onCameraMove: (CameraPosition cameraPosition) {
                      setState(() {
                        zoomValue = cameraPosition.zoom;
                      });
                    },
                    onMapCreated: (controller) {
                      if (!_googleMapController.isCompleted) {
                        _googleMapController.complete(controller);
                      }
                    },
                    markers: {
                      Marker(
                        markerId: const MarkerId("currentLocation"),
                        icon: currentIcon,
                        position: LatLng(
                          currentLocation!.latitude,
                          currentLocation!.longitude,
                        ),
                      ),
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        currentLocation!.latitude,
                        currentLocation!.longitude,
                      ),
                      zoom: zoomValue,
                    ),
                    mapType: MapType.normal,
                  ),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomIconButton(
                assetName: SvgPath.menuDrawer,
                isNotification: false,
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
              CustomIconButton(
                assetName: SvgPath.notification,
                isNotification: true,
                onPressed: () {
                  AuthCubit.get(context).getNotifications();
                  Navigator.pushNamed(context, ScreenName.notificationScreen);
                },
              ),
            ],
          ).onlyDirectionalPadding(
            top: preferredSize.height,
            start: 16,
            end: 16,
          ),
        ],
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final String assetName;
  final bool isNotification;
  final void Function()? onPressed;

  const CustomIconButton({
    super.key,
    required this.assetName,
    required this.isNotification,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomSizedBox(
      height: 40,
      width: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: AppColors.whiteColor,
          elevation: 5,
          foregroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              8.r,
            ),
          ),
        ),
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            SvgPicture.asset(
              assetName,
              width: 24.w,
              height: 24.h,
            ),
            Visibility(
              visible: isNotification,
              child:
                  const CircleAvatar(backgroundColor: Colors.amber, radius: 4),
            )
          ],
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  final Widget child;

  const CustomDrawer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r),
          ),
          color: AppColors.whiteColor, // Change the background color as needed
        ),
        child: child,
      ),
    );
  }
}
