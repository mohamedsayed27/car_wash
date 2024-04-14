import 'package:car_wash/core/parameters/address_parameters/update_address_parameters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/network/error_message_model.dart';
import '../../core/parameters/address_parameters/add_address_parameters.dart';
import '../../core/services/services_locator.dart';
import '../../data/data_source/remote_data_source/address_remote_data_source.dart';
import '../../data/models/address_model/address_model.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/assets_path/images_path.dart';
import '../../../core/google_map/google_map_services.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  final AddressRemoteDatasource _addressRemoteDatasource = sl();

  static AddressCubit get(context) => BlocProvider.of(context);

  BaseErrorModel? baseErrorModel;

  GetAddressesModel? getAddressesModel;

  AddressModel? addressModel;
  bool getAddressLoading = false;

  void chooseSelectedAddress(AddressModel? addressModel) {
    this.addressModel = addressModel;
    print(addressModel);
    currentLocation = LatLng(double.parse(addressModel!.lat.toString()),
        double.parse(addressModel.long.toString()));
    moveCameraPosition();
    emit(ChangeSelectedAddress());
  }

  void onMapTapped({required LatLng latLng,}){
    currentLocation = latLng;
    moveCameraPosition();
    emit(OnMapTapped());
  }
  void getAddress() async {
    getAddressLoading = true;
    emit(GetAllAddressLoadingState());
    final response = await _addressRemoteDatasource.getAddress();
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getAddressLoading = false;
        emit(
          GetAllAddressErrorState(
            error: l.baseErrorModel.errors != null
                ? baseErrorModel!.errors![0]
                : l.baseErrorModel.message ?? "",
          ),
        );
      },
      (r) async {
        getAddressesModel = r;
        getAddressLoading = false;
        emit(GetAllAddressSuccessState());
      },
    );
  }

  void addAddress({
    required AddAddressParameters addAddressParameters,
  }) async {
    emit(AddAddressLoadingState());
    final response = await _addressRemoteDatasource.addAddress(
        parameters: addAddressParameters);
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(
          AddAddressErrorState(
            error: l.baseErrorModel.errors != null
                ? baseErrorModel!.errors![0]
                : l.baseErrorModel.message ?? "",
          ),
        );
      },
      (r) async {
        emit(AddAddressSuccessState());
      },
    );
  }

  void updateAddress({
    required UpdateAddressParameters updateAddressParameters,
  }) async {
    emit(UpdateAddressLoadingState());
    final response = await _addressRemoteDatasource.updateAddress(
        parameters: updateAddressParameters);
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(
          UpdateAddressErrorState(
            error: l.baseErrorModel.errors != null
                ? baseErrorModel!.errors![0]
                : l.baseErrorModel.message ?? "",
          ),
        );
      },
      (r) async {
        emit(UpdateAddressSuccessState());
      },
    );
  }

  void deleteAddress({
    required String addressId,
  }) async {
    emit(DeleteAddressLoadingState());
    final response =
        await _addressRemoteDatasource.deleteAddress(addressId: addressId);
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(
          DeleteAddressErrorState(
            error: l.baseErrorModel.errors != null
                ? baseErrorModel!.errors![0]
                : l.baseErrorModel.message ?? "",
          ),
        );
      },
      (r) async {
        getAddress();
        emit(DeleteAddressSuccessState());
      },
    );
  }

  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();
  late final LatLng sourceLocation;

  final GoogleMapsServices googleMapsServices = GoogleMapsServices();
  List<LatLng> polyLineCoordinates = [];

  BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;
  LatLng? currentLocation;
  Set<Marker> markers = <Marker>{};

  void getCurrentMarker() async {
    final Uint8List? markerIcon =
        await getBytesFromAsset(ImagesPath.locationMapIcon, 100);
    currentIcon = BitmapDescriptor.fromBytes(
      markerIcon!,
      size: Size(56.w, 56.h),
    );
    emit(GetCurrentMarker());
    // setState(() {});
  }

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }

  String? value;

  bool getCurrentLocationLoading = false;

  void moveCameraPosition() async {
    GoogleMapController controller = await googleMapController.future;
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
    addMarker(currentLocation!);
    emit(AnimateGetCurrentLocation());
  }

  void addMarker(LatLng pos) async {
    markers = {};
    markers.add(
      Marker(
        markerId: MarkerId(pos.toString()),
        position: pos,
        icon: currentIcon,
      ),
    );
    emit(AddMarker());
  }

  void getCurrentLocation() async {
    getCurrentLocationLoading = true;
    emit(GetLocationLoading());
    print("entered");
    googleMapsServices.getGeoLocationPosition().then((value) {
      print(value);
      currentLocation = LatLng(value.latitude, value.longitude);
      sourceLocation =
          LatLng(currentLocation!.latitude, currentLocation!.longitude);

      getCurrentLocationLoading = false;
      emit(GetCurrentLocation());
      // setState(() {});
      // getPolyLinePoints(currentLocation);
    }).catchError((error) {
      print(error);
    });
    GoogleMapController controller = await googleMapController.future;
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
    emit(AnimateGetCurrentLocation());
  }

  double zoomValue = 13.5;
}
