import 'dart:io';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GoogleMapsServices {
  GoogleMapsServices();

  Future<List<Placemark>> getUserAddress({
    required double lat,
    required double lng,
  }) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(lat, lng);
    return placeMarks;
  }

  Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
  }

  final LocationSettings locationSettings = Platform.isAndroid
      ? AndroidSettings(
          accuracy: LocationAccuracy.high,
          forceLocationManager: true,
          foregroundNotificationConfig: const ForegroundNotificationConfig(
            notificationText: "running location",
            notificationIcon:
                AndroidResource(name: 'launcher_icon', defType: 'mipmap'),
            notificationTitle: "Running in Background",
            enableWakeLock: true,
          ),
        )
      : Platform.isIOS
          ? AppleSettings(
              accuracy: LocationAccuracy.high,
              activityType: ActivityType.fitness,
              pauseLocationUpdatesAutomatically: true,
              showBackgroundLocationIndicator: false,
            )
          : const LocationSettings(
              accuracy: LocationAccuracy.high,
            );

  Future<Stream<Position>> streamLocation(
      LocationSettings? locationSettings) async {
    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }
}
