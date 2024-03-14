import 'package:equatable/equatable.dart';

class BaseResponseModel<T> extends Equatable {
  final bool? success;
  final String? message;
  final T? result;

  const BaseResponseModel({
    required this.success,
    required this.message,
    this.result,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        success,
        message,
        result,
      ];
}
