

import 'package:equatable/equatable.dart';

import '../address_model/address_model.dart';

class UserResult extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? mobile;
  final int? isVerified;
  final String? avatar;
  final String? type;
  final int? active;
  final List<AddressModel>? addresses;
  final String? createdAt;
  final String? updatedAt;

  const UserResult({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.isVerified,
    this.type,
    this.avatar,
    this.active,
    this.addresses,
    this.createdAt,
    this.updatedAt,
  });

  factory UserResult.fromJson(Map<String, dynamic> json) {
    return UserResult(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      type: json["type"].first,
      mobile: json['mobile'],
      isVerified: json['is_verified'],
      avatar: json['avatar'],
      active: json['active'],
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((address) => AddressModel.fromJson(address))
          .toList(),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    mobile,
    isVerified,
    avatar,
    active,
    addresses,
    createdAt,
    updatedAt,
  ];
}