import 'package:car_wash/data/models/base_response_model.dart';
import 'package:equatable/equatable.dart';

class GetAllChatsModel extends BaseResponseModel<List<ChatItemModel>?> {
  const GetAllChatsModel({
    required super.success,
    required super.message,
    required super.result,
  });

  factory GetAllChatsModel.fromJson(Map<String, dynamic> json) {
    return GetAllChatsModel(
      success: json["success"],
      message: json["message"],
      result: json["result"].isNotEmpty && json["result"] != null
          ? List<ChatItemModel>.from(
              json["result"].map((e) => ChatItemModel.fromJson(e)),
            )
          : null,
    );
  }
}

class ChatItemModel extends Equatable {
  final int? id;
  final int? conversationId;
  final String? clientId;
  final String? representativeId;
  final String? seenClient;
  final String? seenRepresentative;
  final String? message;
  final String? sendAt;

  const ChatItemModel({
    this.id,
    this.conversationId,
    this.clientId,
    this.representativeId,
    this.seenClient,
    this.seenRepresentative,
    this.message,
    this.sendAt,
  });

  // fromJson method
  factory ChatItemModel.fromJson(Map<String, dynamic> json) {
    return ChatItemModel(
      id: json['id'] as int?,
      conversationId: json['conversation_id'] as int?,
      clientId: json['client_id'].toString() as String?,
      representativeId: json['representative_id'].toString() as String?,
      seenClient: json['seen_client'] as String?,
      seenRepresentative: json['seen_representative'] as String?,
      message: json['message'] as String?,
      sendAt: json['send_at'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        id,
        conversationId,
        clientId,
        representativeId,
        seenClient,
        seenRepresentative,
        message,
        sendAt,
      ];
}
