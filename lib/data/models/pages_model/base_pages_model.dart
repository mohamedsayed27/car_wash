import 'package:equatable/equatable.dart';

class BasePagesModel extends Equatable {
  final String? image;
  final String? title;
  final String? content;

  const BasePagesModel({
    this.image,
    this.title,
    this.content,
  });

  @override
  List<Object?> get props => [image, title, content];

  factory BasePagesModel.fromJson(Map<String, dynamic> json) {
    return BasePagesModel(
      image: json['image'],
      title: json['title'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'content': content,
    };
  }
}
