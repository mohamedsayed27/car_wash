import 'package:equatable/equatable.dart';

class AddAddressParameters extends Equatable {
  final String streetName;
  final String buildingNo;
  final String floorNo;
  final String addressType;
  final String lat;
  final String long;

  const AddAddressParameters({
    required this.streetName,
    required this.buildingNo,
    required this.floorNo,
    required this.addressType,
    required this.lat,
    required this.long,
  });

  @override
  List<Object?> get props => [
        streetName,
        buildingNo,
        floorNo,
        addressType,
        lat,
        long,
      ];

  Map<String, dynamic> toJson() {
    return {
      'street_name': streetName,
      'building_no': buildingNo,
      'floor_no': floorNo,
      'address_type': addressType,
      'lat': lat,
      'long': long,
    };
  }
}
