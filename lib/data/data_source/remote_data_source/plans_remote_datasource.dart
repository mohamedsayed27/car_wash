
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/network/error_message_model.dart';
import '../../../core/parameters/auth_parameters/login_parameters.dart';
import '../../models/base_response_model.dart';
import '../../models/plans_model/all_plans_model.dart';
import '../../models/plans_model/user_plans_model.dart';

class PlansRemoteDatasource {
  final DioHelper dioHelper;

  PlansRemoteDatasource({required this.dioHelper});

  Future<Either<ErrorException, GetAllPlansModel>> getAllPlans() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.plans,
      );
      return Right(
        GetAllPlansModel.fromJson(response.data),
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

  Future<Either<ErrorException, GetUserPlansModel>> getUserPlans() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.userPlans,
      );
      return Right(
        GetUserPlansModel.fromJson(response.data),
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

  Future<Either<ErrorException, BaseResponseModel>> subscribePlan({
    required String planId,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.subscribePlan,
        data: FormData.fromMap(
          {
            "plan_id": planId,
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

  Future<Either<ErrorException, BaseResponseModel>> unSubscribePlan({
    required String planId,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.unSubscribePlan,
        data: FormData.fromMap(
          {
            "plan_id": planId,
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
}
