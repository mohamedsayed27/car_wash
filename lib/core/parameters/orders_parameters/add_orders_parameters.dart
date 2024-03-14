import 'package:equatable/equatable.dart';

class AddOrderParameters extends Equatable {
  final String userPlanId;
  final String serviceId;
  final String carTypeId;
  final String userAddressId;
  final String orderDate;
  final String orderTime;

  const AddOrderParameters({
    required this.userPlanId,
    required this.serviceId,
    required this.carTypeId,
    required this.userAddressId,
    required this.orderDate,
    required this.orderTime,
  });

  @override
  List<Object?> get props =>
      [userPlanId, serviceId, carTypeId, userAddressId, orderDate, orderTime];

  Map<String, dynamic> toJson() {
    return {
      'user_plan_id': userPlanId,
      'service_id': serviceId,
      'car_type_id': carTypeId,
      'user_address_id': userAddressId,
      'order_date': orderDate,
      'order_time': orderTime,
    };
  }
}
