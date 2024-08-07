import 'package:car_wash/core/enums/order_progress_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../data/models/order_models/get_all_orders_model.dart';
import '../../../data/models/order_models/order_statistics.dart';
import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/network/error_message_model.dart';
import '../../models/base_response_model.dart';
import '../../models/review_model/get_all_reviews_model.dart';

class RepresentativeDatasource {
  final DioHelper dioHelper;

  RepresentativeDatasource({required this.dioHelper});


  Future<Either<ErrorException, BaseResponseModel>> approveOrder({required String id}) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.approveOrder}/$id",
      );
      return Right(
        BaseResponseModel.fromJson(response.data),
      );
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
          ),
        );
      } else {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel(message: "Error ${e.toString()}", success: false, code: 300, errors: ["Error ${e.toString()}"]),
          ),
        );
      }
    }
  }
  Future<Either<ErrorException, BaseResponseModel>> startOrder({required String id}) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.startOrder}/$id",
      );
      return Right(
        BaseResponseModel.fromJson(response.data),
      );
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
          ),
        );
      } else {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel(message: "Error ${e.toString()}", success: false, code: 300, errors: ["Error ${e.toString()}"]),
          ),
        );
      }
    }
  }
  Future<Either<ErrorException, BaseResponseModel>> finishOrder({required String id}) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.finishOrder}/$id",
      );
      return Right(
        BaseResponseModel.fromJson(response.data),
      );
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
          ),
        );
      } else {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel(message: "Error ${e.toString()}", success: false, code: 300, errors: ["Error ${e.toString()}"]),
          ),
        );
      }
    }
  }
  Future<Either<ErrorException, GetAllOrdersModel>> getMyOrders() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.myOrders,
      );
      return Right(
        GetAllOrdersModel.fromJson(response.data),
      );
    } catch (e) {
      if (e is DioException) {
        if(e.response!.statusCode==500){
          return const Left(
            ErrorException(
              baseErrorModel: BaseErrorModel(message: "Server Error", success: false, code: 500, errors: ["Server Error"]),
            ),
          );
        }else{
          return Left(
            ErrorException(
              baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
            ),
          );
        }
      } else {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel(message: "Error ${e.toString()}", success: false, code: 300, errors: ["Error ${e.toString()}"]),
          ),
        );
      }
    }
  }
  Future<Either<ErrorException, GetSingleOrdersModel>> getNextOrder() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.nextOrder,
      );
      return Right(
        GetSingleOrdersModel.fromJson(response.data),
      );
    } catch (e) {
      if (e is DioException) {
        if(e.response!.statusCode==500){
          return const Left(
            ErrorException(
              baseErrorModel: BaseErrorModel(message: "Server Error", success: false, code: 500, errors: ["Server Error"]),
            ),
          );
        }else{
          return Left(
            ErrorException(
              baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
            ),
          );
        }
      } else {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel(message: "Error ${e.toString()}", success: false, code: 300, errors: ["Error ${e.toString()}"]),
          ),
        );
      }
    }
  }
  Future<Either<ErrorException, GetSingleOrdersModel>> getCurrentOrder() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.currentOrder,
      );
      return Right(
        GetSingleOrdersModel.fromJson(response.data),
      );
    } catch (e) {
      if (e is DioException) {
        if(e.response!.statusCode==500){
          return const Left(
            ErrorException(
              baseErrorModel: BaseErrorModel(message: "Server Error", success: false, code: 500, errors: ["Server Error"]),
            ),
          );
        }else{
          return Left(
            ErrorException(
              baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
            ),
          );
        }
      } else {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel(message: "Error ${e.toString()}", success: false, code: 300, errors: ["Error ${e.toString()}"]),
          ),
        );
      }
    }
  }
  Future<Either<ErrorException, GetAllOrdersModel>> getFinishedOrders() async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.myOrders}/${OrderProgressEnum.finished.name}",
      );
      return Right(
        GetAllOrdersModel.fromJson(response.data),
      );
    } catch (e) {
      if (e is DioException) {
        if(e.response!.statusCode==500){
          return const Left(
            ErrorException(
              baseErrorModel: BaseErrorModel(message: "Server Error", success: false, code: 500, errors: ["Server Error"]),
            ),
          );
        }else{
          return Left(
            ErrorException(
              baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
            ),
          );
        }
      } else {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel(message: "Error ${e.toString()}", success: false, code: 300, errors: ["Error ${e.toString()}"]),
          ),
        );
      }
    }
  }
  Future<Either<ErrorException, GetSingleOrdersModel>> getSingleOrder({required String id}) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.singleOrder}/$id",
      );
      return Right(
        GetSingleOrdersModel.fromJson(response.data),
      );
    } catch (e) {
      if (e is DioException) {
        if(e.response!.statusCode==500){
          return const Left(
            ErrorException(
              baseErrorModel: BaseErrorModel(message: "Server Error", success: false, code: 500, errors: ["Server Error"]),
            ),
          );
        }else{
          return Left(
            ErrorException(
              baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
            ),
          );
        }
      } else {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel(message: "Error ${e.toString()}", success: false, code: 300, errors: ["Error ${e.toString()}"]),
          ),
        );
      }
    }
  }
  Future<Either<ErrorException, GetOrderStatistics>> getOrderStatistics() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.orderStatistics,
      );
      return Right(
        GetOrderStatistics.fromJson(response.data),
      );
    } catch (e) {
      if (e is DioException) {
        if(e.response!.statusCode==500){
          return const Left(
            ErrorException(
              baseErrorModel: BaseErrorModel(message: "Server Error", success: false, code: 500, errors: ["Server Error"]),
            ),
          );
        }else{
          return Left(
            ErrorException(
              baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
            ),
          );
        }
      } else {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel(message: "Error ${e.toString()}", success: false, code: 300, errors: ["Error ${e.toString()}"]),
          ),
        );
      }
    }
  }
  Future<Either<ErrorException, GetAllOrderReviewsModel>> getOrderReviews() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.orderReviews,
      );
      return Right(
        GetAllOrderReviewsModel.fromJson(response.data),
      );
    } catch (e) {
      if (e is DioException) {
        if(e.response!.statusCode==500){
          return const Left(
            ErrorException(
              baseErrorModel: BaseErrorModel(message: "Server Error", success: false, code: 500, errors: ["Server Error"]),
            ),
          );
        }else{
          return Left(
            ErrorException(
              baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
            ),
          );
        }
      } else {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel(message: "Error ${e.toString()}", success: false, code: 300, errors: ["Error ${e.toString()}"]),
          ),
        );
      }
    }
  }
}
