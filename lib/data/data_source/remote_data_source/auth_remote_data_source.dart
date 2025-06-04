import 'package:car_wash/data/models/base_response_model.dart';
import 'package:car_wash/data/models/notification_model/notification_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/network/error_message_model.dart';
import '../../../core/parameters/auth_parameters/login_parameters.dart';
import '../../../core/parameters/auth_parameters/register_parameters.dart';
import '../../../core/parameters/auth_parameters/update_profile_parameters.dart';
import '../../models/auth_models/login_model.dart';
import '../../models/auth_models/register_model.dart';
import '../../models/user_models/get_user_data_model.dart';

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
      print("llllloooogggg");
      print(e);
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

  Future<Either<ErrorException, BaseResponseModel>> sendOtp({
    required String otpCode,
    required String token,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.otp,
        options: Options(
          followRedirects: false,
          maxRedirects: 0,
          validateStatus: (status) => status! < 500,
        ),
        addToken: token,
        data: FormData.fromMap({
          "code": otpCode,
        },),
      );
      return Right(
        BaseResponseModel.fromJson(
          response.data,
        ),
      );
    } catch (e) {
      print(e);
      if (e is DioException) {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel.fromJson(
              e.response!.data,
            ),
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
      print(e);
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

  Future<Either<ErrorException, GetUserDataModel>> updateProfileData({
    required UpdateProfileParameters parameters,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.updateProfile,
        data: FormData.fromMap(
          await parameters.toJson(),
        ),
      );
      return Right(GetUserDataModel.fromJson(response.data));
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

  Future<Either<ErrorException, GetUserDataModel>> getUserData() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.profile,
      );
      return Right(GetUserDataModel.fromJson(response.data));
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

  Future<Either<ErrorException, GetAllNotificationsModel>> getNotifications() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.notifications,
      );
      return Right(GetAllNotificationsModel.fromJson(response.data));
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
