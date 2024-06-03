import 'package:car_wash/data/models/base_response_model.dart';
import 'package:equatable/equatable.dart';

class GetOrderStatistics extends BaseResponseModel<OrderStatistics?> {
  const GetOrderStatistics({
    required super.success,
    required super.message,
    required super.result,
  });

  factory GetOrderStatistics.fromJson(Map<String, dynamic> json) {
    return GetOrderStatistics(
      success: json["success"],
      message: json["message"],
      result: OrderStatistics.fromJson(json["result"]),
    );
  }
}

class OrderStatistics extends Equatable {
  final int? approvedOrders;
  final int? startedOrders;
  final int? finishedOrders;

  const OrderStatistics({
    this.approvedOrders,
    this.startedOrders,
    this.finishedOrders,
  });

  factory OrderStatistics.fromJson(Map<String, dynamic> json) {
    return OrderStatistics(
      approvedOrders: json['approved_orders'] as int?,
      startedOrders: json['started_orders'] as int?,
      finishedOrders: json['finished_orders'] as int?,
    );
  }

  @override
  List<Object?> get props => [
        approvedOrders,
        startedOrders,
        finishedOrders,
      ];
}
