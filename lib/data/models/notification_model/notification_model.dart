import 'package:car_wash/data/models/base_response_model.dart';
import 'package:equatable/equatable.dart';

class GetAllNotificationsModel
    extends BaseResponseModel<List<NotificationItem>?> {
  const GetAllNotificationsModel({
    required super.success,
    required super.message,
    required super.result,
  });

  factory GetAllNotificationsModel.fromJson(Map<String, dynamic> json) {
    return GetAllNotificationsModel(
      success: json["success"],
      message: json["message"],
      result: json["result"].isNotEmpty
          ? List<NotificationItem>.from(
              json["result"].map((e) => NotificationItem.fromJson(e)),
            )
          : null,
    );
  }
}
class NotificationItem extends Equatable{
  final String? notificationTitle;
  final int? orderId;
  final bool? isRead;
  final String? readAt;
  final String? sendAt;

  const NotificationItem({
    this.notificationTitle,
    this.orderId,
    this.isRead,
    this.readAt,
    this.sendAt,
  });

  // fromJson method
  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      notificationTitle: json['notification_title'] as String?,
      orderId: json['order_id'] as int?,
      isRead: json['is_read'] as bool?,
      readAt: json['read_at'] ,
      sendAt: json['send_at'] ,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
