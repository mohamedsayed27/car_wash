import 'package:car_wash/data/models/car_types_model/car_types_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/network/error_message_model.dart';
import '../../../core/parameters/orders_parameters/add_orders_parameters.dart';
import '../../../core/parameters/orders_parameters/update_order_parameters.dart';
import '../../models/base_response_model.dart';
import '../../models/services_model/services_model.dart';

class OrdersRemoteDatasource{
  final DioHelper dioHelper;
  OrdersRemoteDatasource({required this.dioHelper,});


  Future<Either<ErrorException, BaseResponseModel>> getOrders() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.orders,
      );
      return Right(BaseResponseModel.fromJson(response.data,),);
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data,),
          ),
        );
      } else {
        rethrow;
      }
    }
  }


  Future<Either<ErrorException, BaseResponseModel>> getSingleOrder({
    required int orderId,
  }) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.singleOrders}/$orderId",
      );
      return Right(BaseResponseModel.fromJson(response.data),);
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


  Future<Either<ErrorException, BaseResponseModel>> addOrder({
    required AddOrderParameters parameters,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.makeOrders,
        data: FormData.fromMap(
          parameters.toJson(),
        ),
      );
      return Right(BaseResponseModel.fromJson(response.data));
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


  Future<Either<ErrorException, BaseResponseModel>> updateOrder({
    required UpdateOrderParameters parameters,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.updateOrders,
        data: FormData.fromMap(
          parameters.toJson(),
        ),
      );
      return Right(BaseResponseModel.fromJson(response.data));
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


  Future<Either<ErrorException, BaseResponseModel>> deleteOrder({
    required String orderId,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.cancelOrders,
        data: FormData.fromMap(
          {
            "order_id":orderId,
          },
        ),
      );
      return Right(BaseResponseModel.fromJson(response.data));
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



  Future<Either<ErrorException, GetCarTypesModel>> getCarTypes() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.carTypes,
      );
      return Right(GetCarTypesModel.fromJson(response.data,),);
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data,),
          ),
        );
      } else {
        rethrow;
      }
    }
  }



  Future<Either<ErrorException, GetServicesModel>> getServices() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.carTypes,
      );
      return Right(GetServicesModel.fromJson(response.data,),);
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(e.response!.data,),
          ),
        );
      } else {
        rethrow;
      }
    }
  }
}