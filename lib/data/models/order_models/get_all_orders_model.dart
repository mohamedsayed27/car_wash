import 'package:car_wash/data/models/base_response_model.dart';

import 'single_order_model.dart';

class GetAllOrdersModel extends BaseResponseModel <List<SingleOrderModel>?>{

  const GetAllOrdersModel({
    required super.success,
    required super.message,
    required super.result,
  });

  factory GetAllOrdersModel.fromJson(Map<String, dynamic> json) {
    return GetAllOrdersModel(
      success: json["success"],
      message: json["message"],
      result: json["result"].isNotEmpty
          ? List<SingleOrderModel>.from(
              json["result"].map((e) => SingleOrderModel.fromJson(e)),
            )
          : null,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        super.props,
      ];
}
