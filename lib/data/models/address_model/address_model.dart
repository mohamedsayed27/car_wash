import 'package:equatable/equatable.dart';

class AddressModel extends Equatable {
  final int? id;
  final String? streetName;
  final String? buildingNo;
  final String? floorNo;
  final String? flatNo;
  final String? addressType;
  final String? lat;
  final String? long;
  final int? userId;
  final String? createdAt;
  final String? updatedAt;

  const AddressModel({
    this.id,
    this.streetName,
    this.buildingNo,
    this.floorNo,
    this.flatNo,
    this.addressType,
    this.lat,
    this.long,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      streetName: json['street_name'],
      buildingNo: json['building_no'],
      floorNo: json['floor_no'],
      flatNo: json['flat_no'],
      addressType: json['address_type'],
      lat: json['lat'],
      long: json['long'],
      userId: json['user_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  @override
  List<Object?> get props => [
    id,
    streetName,
    buildingNo,
    floorNo,
    flatNo,
    addressType,
    lat,
    long,
    userId,
    createdAt,
    updatedAt,
  ];
}
