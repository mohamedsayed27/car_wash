import '../base_response_model.dart';
import 'review_model.dart';

class GetAllOrderReviewsModel extends BaseResponseModel <ReviewsModel?>{

  const GetAllOrderReviewsModel({
    required super.success,
    required super.message,
    required super.result,
  });

  factory GetAllOrderReviewsModel.fromJson(Map<String, dynamic> json) {
    return GetAllOrderReviewsModel(
      success: json["success"],
      message: json["message"],
      result: json["result"]!=null
          ? ReviewsModel.fromJson(json["result"])
          : null,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    super.props,
  ];
}