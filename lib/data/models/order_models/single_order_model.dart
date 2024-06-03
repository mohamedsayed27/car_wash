import 'package:equatable/equatable.dart';

import '../address_model/address_model.dart';

class SingleOrderModel extends Equatable {
  final int? id;
  final String? carType;
  final String? service;
  final String? userPlan;
  final String? client;
  final String? representative;
  final AddressModel? userAddress;
  final DateTime? scheduleTime;
  final String? orderStatus;
  final String? paymentStatus;
  final String? total;
  final String? paymentMethod;

  const SingleOrderModel({
    this.id,
    this.carType,
    this.service,
    this.userPlan,
    this.client,
    this.representative,
    this.userAddress,
    this.scheduleTime,
    this.orderStatus,
    this.paymentStatus,
    this.total,
    this.paymentMethod,
  });

  factory SingleOrderModel.fromJson(Map<String, dynamic> json) {
    return SingleOrderModel(
      id: json['id'] as int?,
      carType: json['car_type'] as String?,
      service: json['service'] as String?,
      userPlan: json['user_plan'] as String?,
      client: json['client'] as String?,
      representative: json['representative'] as String?,
      userAddress: json['user_address'] != null
          ? AddressModel.fromJson(json['user_address'] as Map<String, dynamic>)
          : null,
      scheduleTime: json['schedule_time'] != null
          ? DateTime.parse(json['schedule_time'] as String)
          : null,
      orderStatus: json['order_status'] as String?,
      paymentStatus: json['payment_status'] as String?,
      total: json['total'] as String?,
      paymentMethod: json['payment_method'] as String?,
    );
  }

  @override
  List<Object?> get props => [
    id,
    carType,
    service,
    userPlan,
    client,
    representative,
    userAddress,
    scheduleTime,
    orderStatus,
    paymentStatus,
    total,
    paymentMethod,
  ];
}
