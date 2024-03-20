import 'package:equatable/equatable.dart';

import '../base_response_model.dart';

class GetAddressesModel extends BaseResponseModel<List<AddressModel>> {
  const GetAddressesModel({
    required super.success,
    required super.message,
    super.result,
  });

  factory GetAddressesModel.fromJson(Map<String, dynamic> json) {
    return GetAddressesModel(
      success: json['success'],
      message: json['message'],
      result: json['result'] != null && json['result'].isNotEmpty
          ? List<AddressModel>.from(
        json['result'].map((e) => AddressModel.fromJson(e)).toList(),
      )
          : null,
    );
  }
}
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
