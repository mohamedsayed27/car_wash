import 'package:car_wash/data/models/base_response_model.dart';

import '../user_models/user_result_model.dart';

class LoginModel extends BaseResponseModel<UserResult> {
  final String? token;
  final int? otpCode;
  final String? otpExpire;

  const LoginModel({
    required super.success,
    required super.message,
    this.token,
    this.otpCode,
    this.otpExpire,
    super.result,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      success: json['success'],
      message: json['message'],
      token: json['token'],
      otpCode: json['otp_code'],
      otpExpire: json['otp_expire'],
      result:
          json['result'] != null ? UserResult.fromJson(json['result']) : null,
    );
  }

  @override
  List<Object?> get props => [
        super.props,
        token,
        otpCode,
        otpExpire,
      ];
}
