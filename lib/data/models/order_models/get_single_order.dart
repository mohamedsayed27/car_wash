import 'package:car_wash/data/models/base_response_model.dart';
import 'package:car_wash/data/models/order_models/single_order_model.dart';

class GetSingleOrderModel extends BaseResponseModel<SingleOrderModel?> {
  const GetSingleOrderModel({
    required super.result,
    required super.message,
    required super.success,
  });

  factory GetSingleOrderModel.fromJson(Map<String, dynamic> json) {
    return GetSingleOrderModel(
      success: json["success"],
      message: json["message"],
      result: SingleOrderModel.fromJson(json["result"]),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        super.props,
      ];
}
