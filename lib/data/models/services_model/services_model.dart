import 'package:car_wash/data/models/base_response_model.dart';
import 'package:equatable/equatable.dart';

class GetServicesModel extends BaseResponseModel<List<ServicesModel>> {
  const GetServicesModel({
    required super.success,
    required super.message,
    super.result,
  });

  factory GetServicesModel.fromJson(Map<String, dynamic> json) {
    return GetServicesModel(
      success: json['success'],
      message: json['message'],
      result: json['result'].isNotEmpty && json['result'] != null
          ? List<ServicesModel>.from(
          json['result'].map((e) => ServicesModel.fromJson(e)))
          : null,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    super.props,
  ];
}

class ServicesModel extends Equatable {
  final int? id;
  final int? price;
  final String? name;
  final String? content;
  final String? image;

  const ServicesModel({
    this.id,
    this.price,
    this.name,
    this.content,
    this.image,
  });

  @override
  List<Object?> get props => [id, name, content, image,price];

  factory ServicesModel.fromJson(Map<String, dynamic> json) {
    return ServicesModel(
      id: json['id'],
      name: json['name'],
      content: json['content'],
      image: json['image'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'content': content,
      'image': image,
    };
  }
}
