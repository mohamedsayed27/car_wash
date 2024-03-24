import 'dart:async';

import 'package:car_wash/core/app_router/screens_name.dart';
import 'package:car_wash/core/app_theme/app_colors.dart';
import 'package:car_wash/core/assets_path/svg_path.dart';
import 'package:car_wash/core/constants/extensions.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/assets_path/images_path.dart';
import '../../../core/constants/constants.dart';
import '../../../core/google_map/google_map_services.dart';
import '../../widgets/choose_car_type_and_location_on_map_widgets/car_type_list.dart';
import '../../widgets/choose_car_type_and_location_on_map_widgets/car_type_widget.dart';
import '../../widgets/drawers/drawer_button.dart';
import '../../widgets/shared_widgets/custom_elevated_button.dart';
import '../vendor_home_screen/vendor_home_screen.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
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
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      ImagesPath.locationOnMap,
    ).then((value) {
      currentIcon = value;
    });
    setState(() {});
  }

  void getCurrentLocation() async {
    print("enter get location");
    googleMapsServices.getGeoLocationPosition().then((value) {
      currentLocation = value;
      sourceLocation =
          LatLng(currentLocation!.latitude, currentLocation!.longitude);
      print(currentLocation);
      setState(() {});
      // getPolyLinePoints(currentLocation);
    });

    GoogleMapController controller = await _googleMapController.future;
    googleMapsServices
        .streamLocation(googleMapsServices.locationSettings)
        .then((value) {
      print(value);
      value.listen((event) {
        print(event.latitude);
        print(event.longitude);
        currentLocation = event;
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
        setState(() {});
      });
    }).catchError((e) {
      print(e);
    });
  }

  double zoomValue = 13.5;

  @override
  void initState() {
    getCurrentMarker();
    getCurrentLocation();
    super.initState();
  }

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
            CustomSizedBox(
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
          currentLocation == null
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
                _googleMapController.complete(controller);
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
                SizedBox(),
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
              vertical: 48.h,
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
                // CarTypeWidget(isSelected: true, svgPath: SvgPath.smallCar, title: "حجم صغير", description: "( 5 مقاعد )"),
                const CarTypeList(),
                const CustomSizedBox(
                  height: 16,
                ),
                CustomElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ScreenName.carServicesScreen);
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
