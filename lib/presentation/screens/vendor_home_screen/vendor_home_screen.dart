import 'dart:async';

import 'package:car_wash/core/app_router/screens_name.dart';
import 'package:car_wash/core/app_theme/app_colors.dart';
import 'package:car_wash/core/app_theme/custom_themes.dart';
import 'package:car_wash/core/assets_path/svg_path.dart';
import 'package:car_wash/core/constants/extensions.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_elevated_button.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
                Navigator.pushNamed(context, ScreenName.vendorOrdersScreen);
              },
            ),
            const CustomSizedBox(
              height: 128,
            ),
            CustomDrawerButton(
              iconPath: SvgPath.logout,
              title: "تسجيل الخروج",
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  ScreenName.loginScreen,
                  (route) => false,
                );
              },
            ),
            // Add more items as needed
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
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
