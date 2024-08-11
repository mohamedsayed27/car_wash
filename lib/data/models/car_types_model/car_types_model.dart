import 'package:car_wash/data/models/base_response_model.dart';
import 'package:equatable/equatable.dart';

class GetContentImageModel extends BaseResponseModel<List<ContentImageModel>> {
  const GetContentImageModel({
    required super.success,
    required super.message,
    super.result,
  });

  factory GetContentImageModel.fromJson(Map<String, dynamic> json) {
    return GetContentImageModel(
      success: json['success'],
      message: json['message'],
      result: json['result'].isNotEmpty && json['result'] != null
          ? List<ContentImageModel>.from(
              json['result'].map((e) => ContentImageModel.fromJson(e)))
          : null,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        super.props,
      ];
}

class ContentImageModel extends Equatable {
  final int? id;
  final String? name;
  final String? content;
  final String? image;
  final int? price;

  const ContentImageModel({
    this.id,
    this.name,
    this.content,
    this.price,
    this.image,
  });

  @override
  List<Object?> get props => [id, name, price, content, image];

  factory ContentImageModel.fromJson(Map<String, dynamic> json) {
    return ContentImageModel(
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
