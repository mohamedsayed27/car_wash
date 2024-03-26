import 'package:car_wash/data/models/base_response_model.dart';
import 'package:equatable/equatable.dart';

class GetCarTypesModel extends BaseResponseModel<List<CarTypesModel>> {
  const GetCarTypesModel({
    required super.success,
    required super.message,
    super.result,
  });

  factory GetCarTypesModel.fromJson(Map<String, dynamic> json) {
    return GetCarTypesModel(
      success: json['success'],
      message: json['message'],
      result: json['result'].isNotEmpty && json['result'] != null
          ? List<CarTypesModel>.from(
              json['result'].map((e) => CarTypesModel.fromJson(e)))
          : null,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        super.props,
      ];
}

class CarTypesModel extends Equatable {
  final int? id;
  final String? name;
  final String? content;
  final String? image;

  const CarTypesModel({
    this.id,
    this.name,
    this.content,
    this.image,
  });

  @override
  List<Object?> get props => [id, name, content, image];

  factory CarTypesModel.fromJson(Map<String, dynamic> json) {
    return CarTypesModel(
      id: json['id'],
      name: json['name'],
      content: json['content'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'content': content,
      'image': image,
    };
  }
}
