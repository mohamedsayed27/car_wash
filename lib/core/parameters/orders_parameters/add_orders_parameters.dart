import 'package:equatable/equatable.dart';

class AddOrderParameters extends Equatable {
  final String userPlanId;
  final String serviceId;
  final String carTypeId;
  final String userAddressId;
  final String orderTimeId;

  const AddOrderParameters({
    required this.userPlanId,
    required this.serviceId,
    required this.carTypeId,
    required this.userAddressId,
    required this.orderTimeId,
  });

  @override
  List<Object?> get props =>
      [userPlanId, serviceId, carTypeId, userAddressId, orderTimeId,];

  Map<String, dynamic> toJson() {
    return {
      'user_plan_id': userPlanId,
      'service_id': serviceId,
      'car_type_id': carTypeId,
      'user_address_id': userAddressId,
      'order_schedule_time_id': orderTimeId,
    };
  }
}
