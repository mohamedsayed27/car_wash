import 'dart:async';
import 'dart:developer';

import 'package:car_wash/core/enums/order_status_enum.dart';
import 'package:car_wash/data/models/order_models/single_order_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';

import '../../../business_logic/representative_cubit/representative_cubit.dart';
import '../../../core/assets_path/images_path.dart';
import '../../../core/google_map/google_map_services.dart';
import '../../../presentation/widgets/shared_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/constants/constants.dart';
import '../../widgets/shared_widgets/custom_elevated_button.dart';
import '../../widgets/shared_widgets/custom_sized_box.dart';

class VendorInProgressOrderArguments extends Equatable {
  final double? lat;
  final double? lng;

  const VendorInProgressOrderArguments({
    this.lat,
    this.lng,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        lat,
        lng,
      ];
}

class VendorInProgressOrderScreen extends StatefulWidget {
  const VendorInProgressOrderScreen({
    super.key,
  });

  @override
  State<VendorInProgressOrderScreen> createState() =>
      _VendorInProgressOrderScreenState();
}

class _VendorInProgressOrderScreenState
    extends State<VendorInProgressOrderScreen> {
  final Completer<GoogleMapController> _googleMapController =
      Completer<GoogleMapController>();
  late LatLng sourceLocation;

  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final GoogleMapsServices googleMapsServices = GoogleMapsServices();
  List<LatLng> polyLineCoordinates = [];

  void getPolyLinePoints(Position? currentLocation) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyBNL4LLOAdkjPV_I69HQ_Y1CtEnz3id_d0",
      PointLatLng(
        currentLocation!.latitude,
        currentLocation.longitude,
      ),
      PointLatLng(
        0.0,
        0.0,
      ),
    );
    if (result.points.isNotEmpty) {
      for (var element in result.points) {
        polyLineCoordinates.add(LatLng(element.latitude, element.longitude));
      }
    }
    setState(() {});
  }

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

  StreamSubscription<Position>? _positionStreamSubscription;

  void getCurrentLocation({
    double? lat,
    double? lng,
  }) async {
    googleMapsServices.getGeoLocationPosition().then((value) {
      currentLocation = value;
      sourceLocation = LatLng(
        lat ?? 0.0,
        lng ?? 0.0,
      );
      setState(() {});
      // getPolyLinePoints(currentLocation);
    }).catchError((e) {});
    GoogleMapController controller = await _googleMapController.future;
    _positionStreamSubscription =
        Geolocator.getPositionStream().listen((Position? event) {
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
      _updateLocationToFirebase(
        "1",
        event?.latitude ?? 0.0,
        event?.longitude ?? 0.0,
      );
      setState(() {});
    });
  }

  double zoomValue = 13.5;

  @override
  void initState() {
    getCurrentMarker();
    super.initState();
  }

  Future<void> _updateLocationToFirebase(
      String orderId, double latitude, double longitude) async {
    try {
      await _databaseReference.child('orders/$orderId/location').set({
        'lat': latitude,
        'lng': longitude,
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RepresentativeCubit, RepresentativeState>(
      listener: (context, state) {
        RepresentativeCubit cubit = RepresentativeCubit.get(context);
        if (state is GetSingleOrderSuccessStates) {
          getCurrentLocation(
            lat: double.parse(
                state.singleOrderModel?.userAddress?.lat.toString() ?? "0.0"),
            lng: double.parse(
                state.singleOrderModel?.userAddress?.long.toString() ?? "0.0"),
          );
        }
        if (state is StartOrderSuccessStates) {
          cubit.getSingleOrder(
              id: cubit.getSingleOrderModel?.id?.toString() ?? "0");
        }
      },
      builder: (context, state) {
        RepresentativeCubit cubit = RepresentativeCubit.get(context);
        return Scaffold(
          extendBody: true,
          appBar: PreferredSize(
            preferredSize: preferredSize,
            child: const CustomAppBar(
              title: "تفاصيل الطلب",
            ),
          ),
          body: cubit.getSingleOrderLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : CustomSizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: currentLocation == null
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : GoogleMap(
                          myLocationButtonEnabled: false,
                          mapType: MapType.normal,
                          onCameraMove: (CameraPosition cameraPosition) {
                            setState(() {
                              zoomValue = cameraPosition.zoom;
                            });
                          },
                          initialCameraPosition: CameraPosition(
                            target: LatLng(currentLocation!.latitude,
                                currentLocation!.longitude),
                            zoom: zoomValue,
                          ),
                          polylines: {
                            Polyline(
                              polylineId: const PolylineId("route"),
                              points: polyLineCoordinates,
                              color: Colors.red,
                              width: 6,
                            )
                          },
                          onMapCreated: (controller) {
                            if (!_googleMapController.isCompleted) {
                              _googleMapController.complete(controller);
                            }
                          },
                          markers: {
                            Marker(
                              markerId: const MarkerId("sourceLocation"),
                              position: LatLng(sourceLocation.latitude,
                                  sourceLocation.longitude,),
                            ),
                            Marker(
                              markerId: const MarkerId("currentLocation"),
                              icon: currentIcon,
                              position: LatLng(currentLocation!.latitude,
                                  currentLocation!.longitude,),
                            ),
                          },
                        ),
                ),
          bottomNavigationBar: cubit.getSingleOrderLoading
              ? null
              : Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 38.w,
                    vertical: 38.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, -2.h),
                        blurRadius: 12.r,
                        color: AppColors.shadowColor(value: 0.15),
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.r),
                      topLeft: Radius.circular(20.r),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "توقيت البدء",
                            style: CustomThemes.primaryColorTextTheme(context)
                                .copyWith(
                              fontSize: 16.sp,
                              fontWeight: CustomFontWeights.bold,
                            ),
                          ),
                          Text(
                            cubit.getSingleOrderModel?.scheduleTime?.time ?? "",
                            style: CustomThemes.primaryColorTextTheme(context)
                                .copyWith(
                              fontSize: 16.sp,
                              fontWeight: CustomFontWeights.bold,
                            ),
                          ),
                        ],
                      ),
                      const CustomSizedBox(
                        height: 16,
                      ),
                      CustomElevatedButton(
                        onPressed: cubit.startOrderLoading
                            ? null
                            : () {
                                cubit.finishOrder(
                                    id: cubit.getSingleOrderModel?.id
                                            ?.toString() ??
                                        "0");
                              },
                        text: cubit.getSingleOrderModel?.orderStatus
                                    ?.toString() ==
                                OrderStatusEnum.assigned.name
                            ? "بدء الطلب"
                            : cubit.getSingleOrderModel?.orderStatus
                                        ?.toString() ==
                                    OrderStatusEnum.started.name
                                ? "انهاء الطلب"
                                : cubit.getSingleOrderModel?.orderStatus
                                            ?.toString() ==
                                        OrderStatusEnum.finished.name
                                    ? "تم انهاء الطلب"
                                    : cubit.getSingleOrderModel?.orderStatus
                                                ?.toString() ==
                                            OrderStatusEnum.pending.name
                                        ? "لم يتم الاشارة الي الطلب"
                                        : "",
                        height: 48,
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
