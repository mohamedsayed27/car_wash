import 'package:car_wash/data/models/base_response_model.dart';
import 'package:car_wash/data/models/base_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/network/error_message_model.dart';
import '../../../core/parameters/auth_parameters/login_parameters.dart';
import '../../../core/parameters/auth_parameters/register_parameters.dart';
import '../../models/auth_models/login_model.dart';
import '../../models/auth_models/register_model.dart';

class AuthRemoteDataSource {
  final DioHelper dioHelper;

  AuthRemoteDataSource({required this.dioHelper});

  Future<Either<ErrorException, LoginModel>> login({
    required LoginParameters parameters,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.login,
        data: FormData.fromMap(
          parameters.toJson(),
        ),
      );
      return Right(LoginModel.fromJson(response.data));
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

  Future<Either<ErrorException, BaseResponseModel>> sendOtp({
    required String otpCode,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.login,
        data: FormData.fromMap(
          {
            "code": otpCode,
          },
        ),
      );
      return Right(
        BaseResponseModel.fromJson(
          response.data,
        ),
      );
    } catch (e) {
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(
              e.response!.data,
            ),
          ),
        );
      } else {
        rethrow;
      }
    }
  }

  Future<Either<ErrorException, RegisterModel>> register({
    required RegisterParameters parameters,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.register,
        data: FormData.fromMap(
          await parameters.toJson(),
        ),
      );
      return Right(RegisterModel.fromJson(response.data));
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
