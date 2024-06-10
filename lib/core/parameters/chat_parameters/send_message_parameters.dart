import 'package:equatable/equatable.dart';

class SendMessageParameters extends Equatable {
  final String type;
  final String message;
  final String orderId;

  const SendMessageParameters({
    required this.type,
    required this.message,
    required this.orderId,
  });

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "type": type,
        "message": message,
      };

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
