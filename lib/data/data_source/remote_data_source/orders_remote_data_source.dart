import 'dart:developer';

import '../../../data/models/car_types_model/car_types_model.dart';
import '../../../data/models/order_models/get_all_orders_model.dart';
import '../../../data/models/order_models/get_single_order.dart';
import '../../../data/models/time_schedule/time_schedule.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/network/error_message_model.dart';
import '../../../core/parameters/orders_parameters/add_orders_parameters.dart';
import '../../../core/parameters/orders_parameters/update_order_parameters.dart';
import '../../models/base_response_model.dart';

class OrdersRemoteDatasource{
  final DioHelper dioHelper;
  OrdersRemoteDatasource({required this.dioHelper,});


  Future<Either<ErrorException, GetAllOrdersModel>> getOrders() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.orders,
      );
      return Right(GetAllOrdersModel.fromJson(response.data,),);
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


  Future<Either<ErrorException, GetAllOrdersModel>> rateOrder({
    required String orderId,
    required String rate,
    required String review,
}) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.rateOrder,
        data: FormData.fromMap({
          "order_id":orderId,
          "rate":rate,
          "review":review,
        })
      );
      return Right(GetAllOrdersModel.fromJson(response.data,),);
    } catch (e) {
      print(e);
      if (e is DioException) {
        if(e.response!.statusCode==500){
          log(e.response.toString());
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


  Future<Either<ErrorException, GetSingleOrderModel>> getSingleOrder({
    required int orderId,
  }) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.singleOrders}/$orderId",
      );
      return Right(GetSingleOrderModel.fromJson(response.data),);
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
        print(e);
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



  Future<Either<ErrorException, GetContentImageModel>> getCarTypes() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.carTypes,
      );
      return Right(GetContentImageModel.fromJson(response.data,),);
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



  Future<Either<ErrorException, GetContentImageModel>> getServices() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.services,
      );
      return Right(GetContentImageModel.fromJson(response.data,),);
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

  //
  //
  // Future<Either<ErrorException, GetServicesModel>> getServices() async {
  //   try {
  //     final response = await dioHelper.getData(
  //       url: EndPoints.services,
  //     );
  //     return Right(GetServicesModel.fromJson(response.data,),);
  //   } catch (e) {
  //     if (e is DioException) {
  //       return Left(
  //         ErrorException(
  //           baseErrorModel: BaseErrorModel.fromJson(e.response!.data,),
  //         ),
  //       );
  //     } else {
  //       rethrow;
  //     }
  //   }
  // }

  Future<Either<ErrorException, GetAllTimeScheduleModel>> getTimeSchedule() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.timeSchedule,
      );
      return Right(GetAllTimeScheduleModel.fromJson(response.data,),);
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