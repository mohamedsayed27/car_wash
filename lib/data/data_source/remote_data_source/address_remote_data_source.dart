import 'package:car_wash/core/parameters/address_parameters/add_address_parameters.dart';
import 'package:car_wash/core/parameters/address_parameters/update_address_parameters.dart';
import 'package:car_wash/data/models/address_model/address_model.dart';
import 'package:car_wash/data/models/base_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/dio_helper.dart';
import '../../../core/network/error_message_model.dart';

class AddressRemoteDatasource {
  final DioHelper dioHelper;
  AddressRemoteDatasource({required this.dioHelper});

  Future<Either<ErrorException, GetAddressesModel>> getAddress() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.addresses,
      );
      return Right(
        GetAddressesModel.fromJson(response.data),
      );
    } catch (e) {
      print(e);
      if (e is DioException) {
        if (e.response!.statusCode == 500) {
          return const Left(
            ErrorException(
              baseErrorModel: BaseErrorModel(
                  message: "Server Error", success: false, code: 500, errors: ["Server Error"]),
            ),
          );
        } else {
          return Left(
            ErrorException(
              baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
            ),
          );
        }
      } else {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel(
                message: "Error ${e.toString()}",
                success: false,
                code: 300,
                errors: ["Error ${e.toString()}"]),
          ),
        );
      }
    }
  }

  Future<Either<ErrorException, BaseResponseModel>> addAddress({
    required AddAddressParameters parameters,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.addAddress,
        data: FormData.fromMap(
          parameters.toJson(),
        ),
      );
      return Right(BaseResponseModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 500) {
          return const Left(
            ErrorException(
              baseErrorModel: BaseErrorModel(
                  message: "Server Error", success: false, code: 500, errors: ["Server Error"]),
            ),
          );
        } else {
          return Left(
            ErrorException(
              baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
            ),
          );
        }
      } else {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel(
                message: "Error ${e.toString()}",
                success: false,
                code: 300,
                errors: ["Error ${e.toString()}"]),
          ),
        );
      }
    }
  }

  Future<Either<ErrorException, BaseResponseModel>> updateAddress({
    required UpdateAddressParameters parameters,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.updateAddress,
        data: FormData.fromMap(
          parameters.toJson(),
        ),
      );
      return Right(BaseResponseModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 500) {
          return const Left(
            ErrorException(
              baseErrorModel: BaseErrorModel(
                  message: "Server Error", success: false, code: 500, errors: ["Server Error"]),
            ),
          );
        } else {
          return Left(
            ErrorException(
              baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
            ),
          );
        }
      } else {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel(
                message: "Error ${e.toString()}",
                success: false,
                code: 300,
                errors: ["Error ${e.toString()}"]),
          ),
        );
      }
    }
  }

  Future<Either<ErrorException, BaseResponseModel>> deleteAddress({
    required String addressId,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.deleteAddress,
        data: FormData.fromMap(
          {
            "address_id": addressId,
          },
        ),
      );
      return Right(BaseResponseModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 500) {
          return const Left(
            ErrorException(
              baseErrorModel: BaseErrorModel(
                  message: "Server Error", success: false, code: 500, errors: ["Server Error"]),
            ),
          );
        } else {
          return Left(
            ErrorException(
              baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
            ),
          );
        }
      } else {
        return Left(
          ErrorException(
            baseErrorModel: BaseErrorModel(
                message: "Error ${e.toString()}",
                success: false,
                code: 300,
                errors: ["Error ${e.toString()}"]),
          ),
        );
      }
    }
  }
}
