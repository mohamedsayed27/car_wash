import 'package:car_wash/data/models/base_response_model.dart';
import 'package:equatable/equatable.dart';

import '../user_models/user_result_model.dart';

class RegisterModel extends BaseResponseModel<UserResult> {
  final String? token;

  const RegisterModel({
    required super.success,
    required super.message,
    this.token,
    super.result,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      success: json['success'],
      message: json['message'],
      token: json['token'],
      result:
          json['result'] != null ? UserResult.fromJson(json['result']) : null,
    );
  }

  @override
  List<Object?> get props => [super.props, token];
}

