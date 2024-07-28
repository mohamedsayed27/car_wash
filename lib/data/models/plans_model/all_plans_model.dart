import 'package:car_wash/data/models/base_response_model.dart';
import 'package:equatable/equatable.dart';

class GetAllPlansModel extends BaseResponseModel<List<AllPlansModel>> {
  const GetAllPlansModel({
    required super.success,
    required super.message,
    super.result,
  });

  factory GetAllPlansModel.fromJson(Map<String, dynamic> json) {
    return GetAllPlansModel(
      success: json['success'],
      message: json['message'],
      result: json['result'] != null && json['result'].isNotEmpty
          ? List<AllPlansModel>.from(
              json['result'].map((e) => AllPlansModel.fromJson(e)).toList(),
            )
          : null,
    );
  }
}

class AllPlansModel extends Equatable {
  final int? id;
  final double? price;
  final String? subscriptionType;
  final int? washNumber;
  final int? isSubscribed;
  final int? userIdPlan;
  final String? name;
  final String? content;

  const AllPlansModel({
    this.id,
    this.price,
    this.userIdPlan,
    this.isSubscribed,
    this.subscriptionType,
    this.washNumber,
    this.name,
    this.content,
  });

  @override
  List<Object?> get props => [
        id,
        price,
        subscriptionType,
        washNumber,
        name,
    userIdPlan,
    isSubscribed,
        content,
      ];

  factory AllPlansModel.fromJson(Map<String, dynamic> json) {
    return AllPlansModel(
      id: json['id'],
      price: json['price']?.toDouble(),
      subscriptionType: json['subscription_type'],
      washNumber: json['wash_number'],
      name: json['name'],
      userIdPlan: json['user_plan_id'],
      content: json['content'],
      isSubscribed: json['is_subscribed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'subscription_type': subscriptionType,
      'wash_number': washNumber,
      'name': name,
      'content': content,
    };
  }
}

class PlanTranslation extends Equatable {
  final int? id;
  final int? planId;
  final String? locale;
  final String? name;
  final String? content;
  final String? createdAt;
  final String? updatedAt;

  const PlanTranslation({
    this.id,
    this.planId,
    this.locale,
    this.name,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props =>
      [id, planId, locale, name, content, createdAt, updatedAt,];

  factory PlanTranslation.fromJson(Map<String, dynamic> json) {
    return PlanTranslation(
      id: json['id'],
      planId: json['plan_id'],
      locale: json['locale'],
      name: json['name'],
      content: json['content'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plan_id': planId,
      'locale': locale,
      'name': name,
      'content': content,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
