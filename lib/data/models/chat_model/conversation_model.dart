import 'package:car_wash/data/models/base_response_model.dart';
import 'package:equatable/equatable.dart';
class GetAllConversation extends BaseResponseModel<List<ConversationItem>?>{
  const GetAllConversation({required super.success, required super.message,required super.result,});


  factory GetAllConversation.fromJson(Map<String, dynamic> json) {
    return GetAllConversation(
      success: json["success"],
      message: json["message"],
      result: json["result"].isNotEmpty && json["result"] !=null
          ? List<ConversationItem>.from(
        json["result"].map((e) => ConversationItem.fromJson(e)),
      )
          : null,
    );
  }
}
class ConversationItem extends Equatable {
  final int? id;
  final int? order;
  final String? status;
  final String? user;
  final String? message;
  final String? sendAt;
  final String? avatar;

  const ConversationItem({
    this.id,
    this.order,
    this.status,
    this.user,
    this.message,
    this.sendAt,
    this.avatar,
  });

  // fromJson method
  factory ConversationItem.fromJson(Map<String, dynamic> json) {
    return ConversationItem(
      id: json['id'] as int?,
      order: json['order'] as int?,
      status: json['status'] as String?,
      user: json['user'] as String?,
      message: json['message'] as String?,
      sendAt: json['send_at'] as String?,
      avatar: json['avatar'] as String?,
    );
  }

  @override
  List<Object?> get props => [
    id,
    order,
    status,
    user,
    message,
    sendAt,
    avatar,
  ];
}
