import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../data/models/order_models/get_all_orders_model.dart';
import '../../../data/models/order_models/order_statistics.dart';
import '../../../data/models/order_models/single_order_model.dart';
import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/network/error_message_model.dart';
import '../../models/base_response_model.dart';

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
        rethrow;
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
        rethrow;
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
        rethrow;
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
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
          ),
        );
      } else {
        rethrow;
      }
    }
  }
  Future<Either<ErrorException, SingleOrderModel>> getSingleOrder({required String id}) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.singleOrder}/$id",
      );
      return Right(
        SingleOrderModel.fromJson(response.data),
      );
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
          ),
        );
      } else {
        rethrow;
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
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
          ),
        );
      } else {
        rethrow;
      }
    }
  }
}
