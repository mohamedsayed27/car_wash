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
class GetSingleOrdersModel extends BaseResponseModel <SingleOrderModel?>{

  const GetSingleOrdersModel({
    required super.success,
    required super.message,
    required super.result,
  });

  factory GetSingleOrdersModel.fromJson(Map<String, dynamic> json) {
    return GetSingleOrdersModel(
      success: json["success"],
      message: json["message"],
      result: json["result"]!=null?SingleOrderModel.fromJson(json["result"])
          : null,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        super.props,
      ];
}
