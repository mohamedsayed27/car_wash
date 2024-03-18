import 'package:car_wash/data/models/base_response_model.dart';
import 'package:equatable/equatable.dart';

class GetAllPlansModel extends BaseResponseModel<List<AllPlansModel>> {
  GetAllPlansModel({
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
  final int? status;
  final int? washNumber;
  final String? createdBy;
  final String? createdAt;
  final String? updatedAt;
  final String? name;
  final String? content;
  final List<PlanTranslation>? translations;

  const AllPlansModel({
    this.id,
    this.price,
    this.subscriptionType,
    this.status,
    this.washNumber,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.content,
    this.translations,
  });

  @override
  List<Object?> get props => [
        id,
        price,
        subscriptionType,
        status,
        washNumber,
        createdBy,
        createdAt,
        updatedAt,
        name,
        content,
        translations,
      ];

  factory AllPlansModel.fromJson(Map<String, dynamic> json) {
    List<PlanTranslation>? translations;
    if (json['translations'] != null) {
      translations = [];
      json['translations'].forEach((translationJson) {
        translations?.add(PlanTranslation.fromJson(translationJson));
      });
    }
    return AllPlansModel(
      id: json['id'],
      price: json['price']?.toDouble(),
      subscriptionType: json['subscription_type'],
      status: json['status'],
      washNumber: json['wash_number'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      name: json['name'],
      content: json['content'],
      translations: translations,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>>? translationsJson;
    if (translations != null) {
      translationsJson =
          translations!.map((translation) => translation.toJson()).toList();
    }
    return {
      'id': id,
      'price': price,
      'subscription_type': subscriptionType,
      'status': status,
      'wash_number': washNumber,
      'created_by': createdBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'name': name,
      'content': content,
      'translations': translationsJson,
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
      [id, planId, locale, name, content, createdAt, updatedAt];

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
