import 'package:equatable/equatable.dart';

class AddOrderParameters extends Equatable {
  final String? userPlanId;
  final String? serviceId;
  final String? carTypeId;
  final String? userAddressId;
  final String? orderTimeId;

  const AddOrderParameters({
    this.userPlanId,
    this.serviceId,
    this.carTypeId,
    this.userAddressId,
    this.orderTimeId,
  });

  @override
  List<Object?> get props => [
        userPlanId,
        serviceId,
        carTypeId,
        userAddressId,
        orderTimeId,
      ];

  Map<String, dynamic> toJson() {
    return {
      if (userPlanId != null) 'user_plan_id': userPlanId,
      if (serviceId != null) 'service_id': serviceId,
      if (carTypeId != null) 'car_type_id': carTypeId,
      if (userAddressId != null) 'user_address_id': userAddressId,
      if (orderTimeId != null) 'order_schedule_time_id': orderTimeId,
    };
  }
}
