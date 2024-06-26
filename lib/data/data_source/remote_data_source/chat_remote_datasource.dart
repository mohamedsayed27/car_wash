import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/error/error_exception.dart';
import '../../../core/network/api_end_points.dart';
import '../../../core/network/error_message_model.dart';
import '../../../core/parameters/chat_parameters/send_message_parameters.dart';
import '../../models/chat_model/chat_model.dart';
import '../../../core/network/dio_helper.dart';
import '../../../data/models/base_response_model.dart';
import '../../../data/models/chat_model/conversation_model.dart';

class ChatRemoteDatasource {
  final DioHelper dioHelper;

  ChatRemoteDatasource({required this.dioHelper});

  Future<Either<ErrorException, GetAllConversation>> getAllConversation({
    required String type,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.chatOrder,
        data: FormData.fromMap({"type": type}),
      );
      print(response);
      return Right(GetAllConversation.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        print(e);
        if (e.response?.statusCode != 500) {
          return Left(
            ErrorException(
              baseErrorModel: BaseErrorModel.fromJson(e.response!.data),
            ),
          );
        } else {
          return const Left(
            ErrorException(
              baseErrorModel: BaseErrorModel(
                message: "Server error",
                success: false,
                code: 500,
                errors: [
                  "Server error",
                ],
              ),
            ),
          );
        }
      } else {
        rethrow;
      }
    }
  }

  Future<Either<ErrorException, BaseResponseModel>> senMessage({
    required SendMessageParameters sendMessageParameters,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.sendChatOrder,
        data: FormData.fromMap(
          sendMessageParameters.toJson(),
        ),
      );
      print(response);
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

  Future<Either<ErrorException, GetAllChatsModel>> getChatMessages({
    required String id,
  }) async {
    try {
      final response = await dioHelper.getData(
        url: "${EndPoints.openChatOrder}/$id",
      );
      print(response);
      return Right(GetAllChatsModel.fromJson(response.data));
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
