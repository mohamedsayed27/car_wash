import 'package:equatable/equatable.dart';

class UpdateOrderParameters extends Equatable {
  final String userPlanId;
  final String serviceId;
  final String carTypeId;
  final String userAddressId;
  final String orderTimeId;
  final String orderId;

  const UpdateOrderParameters({
    required this.userPlanId,
    required this.serviceId,
    required this.carTypeId,
    required this.userAddressId,
    required this.orderTimeId,
    required this.orderId,
  });

  @override
  List<Object?> get props => [
        userPlanId,
        serviceId,
        carTypeId,
        orderId,
        userAddressId,
        orderTimeId,
      ];

  Map<String, dynamic> toJson() {
    return {
      'plan_id': userPlanId,
      'order_id': orderId,
      'service_id': serviceId,
      'car_type_id': carTypeId,
      'user_address_id': userAddressId,
      'order_schedule_time_id': orderTimeId,
    };
  }
}
