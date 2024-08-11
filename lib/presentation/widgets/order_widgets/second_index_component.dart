import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../shared_widgets/custom_sized_box.dart';

class SecondIndexComponent extends StatefulWidget {
  final String orderId;
  const SecondIndexComponent({super.key, required this.orderId});

  @override
  State<SecondIndexComponent> createState() => _SecondIndexComponentState();
}

class _SecondIndexComponentState extends State<SecondIndexComponent> {
  final DatabaseReference _databaseReference =
  FirebaseDatabase.instance.ref();
  StreamSubscription? _locationSubscription;
  double? _latitude;
  double? _longitude;
  @override
  void initState() {
    super.initState();
    _startListeningToLocationChanges();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }
  bool getLocationLoading = false;

  void _startListeningToLocationChanges() {
    getLocationLoading = true;
    setState(() {

    });
    _locationSubscription = _databaseReference
        .child('orders/1/location')
        .onValue
        .listen((event) {
          print(event.snapshot.value);
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      print(data?['lat']);
      print(data?['lng']);
      setState(() {
        _latitude = data?['lat']??0.0;
        _longitude = data?['lng']??0.0;
      });
    });
    getLocationLoading = false;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return   CustomSizedBox(
      height: 660,
      width: double.infinity,
      child: getLocationLoading?const Center(child: CircularProgressIndicator(),):GoogleMap(
        myLocationButtonEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(_latitude??0.0, _longitude??0.0),
          zoom: 11.5,
        ),
      ),
    );
  }
}
