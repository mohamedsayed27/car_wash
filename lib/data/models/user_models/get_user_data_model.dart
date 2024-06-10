import 'package:car_wash/data/models/base_response_model.dart';

import 'user_result_model.dart';

class GetUserDataModel extends BaseResponseModel<UserResult?> {
  const GetUserDataModel({
    required super.success,
    required super.message,
    required super.result,
  });

  factory GetUserDataModel.fromJson(Map<String, dynamic> json) {
    return GetUserDataModel(
      success: json['success'],
      message: json['message'],
      result:
          json['result'] != null ? UserResult.fromJson(json['result']) : null,
    );
  }
}
