import 'package:equatable/equatable.dart';

import '../address_model/address_model.dart';

class SingleOrderModel extends Equatable {
  final int? id;
  final String? carType;
  final String? service;
  final String? userPlan;
  final int? orderRate;
  final Client? client;
  final Representative? representative;
  final AddressModel? userAddress;
  final String? orderStatus;
  final String? paymentStatus;
  final ScheduleTime? scheduleTime;
  final String? total;
  final String? paymentMethod;

  const SingleOrderModel({
    this.id,
    this.carType,
    this.service,
    this.orderRate,
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
      client:  Client.fromJson(json['client']),
      representative: json['representative']!=null? Representative.fromJson(json['representative']):null,
      userAddress: json['user_address'] != null
          ? AddressModel.fromJson(json['user_address'] as Map<String, dynamic>)
          : null,
      scheduleTime: json['schedule_time'] != null
          ? ScheduleTime.fromJson(json['schedule_time']): null,
      orderStatus: json['order_status'] as String?,
      paymentStatus: json['payment_status'] as String?,
      orderRate: json['order_rate'] !=null?double.parse(json['order_rate'].toString()).round():null,
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
    orderRate,
  ];
}

class ScheduleTime extends Equatable {
  final int? id;
  final String? time;
  final String? date;
  final int? availability;

  const ScheduleTime({this.id, this.time,this.date, this.availability});

  // fromJson method
  factory ScheduleTime.fromJson(Map<String, dynamic> json) {
    return ScheduleTime(
      id: json['id'] as int?,
      time: json['time'] as String?,
      date: json['date'] as String?,
      availability: json['availability'] as int?,
    );
  }

  @override
  List<Object?> get props => [id, time, availability,];
}

class Client extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? mobile;
  final String? avatar;

  const Client({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.avatar,
  });

  @override
  List<Object?> get props => [id, name, email, mobile, avatar];

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
      avatar: json['avatar'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'avatar': avatar,
    };
  }
}

class Representative extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? mobile;
  final String? avatar;

  const Representative({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.avatar,
  });

  @override
  List<Object?> get props => [id, name, email, mobile, avatar];

  factory Representative.fromJson(Map<String, dynamic> json) {
    return Representative(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
      avatar: json['avatar'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'avatar': avatar,
    };
  }
}
