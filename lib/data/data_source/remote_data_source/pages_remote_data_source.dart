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

  Future<Either<ErrorException, BasePagesModel>> aboutUs() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.aboutUs,
      );
      return Right(
        BasePagesModel.fromJson(
          response.data["result"],
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

  Future<Either<ErrorException, BasePagesModel>> termsAndConditions() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.termsConditions,
      );
      return Right(
        BasePagesModel.fromJson(
          response.data["result"],
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

  Future<Either<ErrorException, BasePagesModel>> privacyPolicy() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.privacyPolicy,
      );
      return Right(
        BasePagesModel.fromJson(
          response.data["result"],
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
}
