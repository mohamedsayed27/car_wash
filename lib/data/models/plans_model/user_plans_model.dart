import 'package:car_wash/data/models/base_response_model.dart';
import 'package:equatable/equatable.dart';

class GetUserPlansModel extends BaseResponseModel<List<UserPlansModel>> {
  const GetUserPlansModel({
    required super.success,
    required super.message,
    super.result,
  });

  factory GetUserPlansModel.fromJson(Map<String, dynamic> json) {
    return GetUserPlansModel(
      success: json['success'],
      message: json['message'],
      result: json['result'] != null && json['result'].isNotEmpty
          ? List<UserPlansModel>.from(
              json['result'].map((e) => UserPlansModel.fromJson(e)).toList(),
            )
          : null,
    );
  }
}

class UserPlansModel extends Equatable {
  final int? id;
  final int? planId;
  final double? planPrice;
  final int? userId;
  final int? washNumber;
  final int? publish;

  const UserPlansModel({
    this.id,
    this.planId,
    this.planPrice,
    this.userId,
    this.washNumber,
    this.publish,
  });

  @override
  List<Object?> get props =>
      [id, planId, planPrice, userId, washNumber, publish,];

  factory UserPlansModel.fromJson(Map<String, dynamic> json) {
    return UserPlansModel(
      id: json['id'],
      planId: json['plan_id'],
      planPrice: json['plan_price']?.toDouble(),
      userId: json['user_id'],
      washNumber: json['wash_number'],
      publish: json['publish'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plan_id': planId,
      'plan_price': planPrice,
      'user_id': userId,
      'wash_number': washNumber,
      'publish': publish,
    };
  }
}
