import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../business_logic/address_cubit/address_cubit.dart';
import 'custom_sized_box.dart';

class AddressGoogleMapWidget extends StatelessWidget {
  final void Function(LatLng)? onTap;
  const AddressGoogleMapWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressCubit, AddressState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AddressCubit.get(context);
        return cubit.getCurrentLocationLoading
            ? const Center(child: CircularProgressIndicator.adaptive())
            : CustomSizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  children: [
                    Expanded(
                      child: GoogleMap(
                        myLocationButtonEnabled: false,
                        // onCameraMove: (CameraPosition cameraPosition) {
                        //   setState(() {
                        //     cubit.zoomValue = cameraPosition.zoom;
                        //   });
                        // },
                        onMapCreated: (controller) {
                          if(!cubit.googleMapController.isCompleted){
                            cubit.googleMapController.complete(controller);
                          }
                        },
                        onTap: onTap,
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
                    ),
                    const CustomSizedBox(height: 128,),
                  ],
                ),
              );
      },
    );
  }
}
