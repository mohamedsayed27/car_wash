import 'package:car_wash/core/network/dio_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../models/pages_model/base_pages_model.dart';
import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/error_message_model.dart';

class PagesRemoteDataSource {
  final DioHelper dioHelper;

  PagesRemoteDataSource({
    required this.dioHelper,
  });

  Future<Either<ErrorException, BasePagesModel?>> aboutUs() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.aboutUs,
      );
      return Right(
        response.data["result"]!=null?BasePagesModel.fromJson(
          response.data["result"],
        ):null,
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

  Future<Either<ErrorException, BasePagesModel?>> termsAndConditions() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.termsConditions,
      );
      return Right(
        response.data["result"]!=null?BasePagesModel.fromJson(
          response.data["result"],
        ):null,
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

  Future<Either<ErrorException, BasePagesModel?>> privacyPolicy() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.privacyPolicy,
      );
      return Right(
        response.data["result"]!=null?BasePagesModel.fromJson(
          response.data["result"],
        ):null,
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
