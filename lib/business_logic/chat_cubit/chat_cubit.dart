import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/network/error_message_model.dart';
import '../../core/services/services_locator.dart';
import '../../data/data_source/remote_data_source/chat_remote_datasource.dart';
import '../../core/parameters/chat_parameters/send_message_parameters.dart';
import '../../data/models/chat_model/chat_model.dart';
import '../../data/models/chat_model/conversation_model.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRemoteDatasource _chatRemoteDatasource = sl();

  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);

  BaseErrorModel? baseErrorModel;

  List<ChatItemModel> chats = [];
  List<ConversationItem> conversations = [];

  bool getChatLoading = false;

  void getChatMessages({required String id}) async {
    getChatLoading = true;
    emit(GetChatLoadingStates());
    final response = await _chatRemoteDatasource.getChatMessages(id: id);

    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getChatLoading = false;
        emit(GetChatErrorStates(error: l.baseErrorModel.message));
      },
      (r) {
        chats = r.result?.reversed.toList() ?? [];
        getChatLoading = false;
        chats.forEach((e){
          print(e.clientId);
          print(e.clientId?.isEmpty);
        });
        // print(r);
        emit(GetChatSuccessStates());
      },
    );
  }

  bool getAllConversationsLoading = false;
  void getAllConversation({required String type}) async {
    getAllConversationsLoading = true;
    emit(GetConversationLoadingStates());
    final response = await _chatRemoteDatasource.getAllConversation(type: type);

    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getAllConversationsLoading = false;
        emit(GetConversationErrorStates(error: l.baseErrorModel.message));
      },
      (r) {
        conversations = r.result ?? [];
        getAllConversationsLoading = false;
        emit(GetConversationSuccessStates());
      },
    );
  }
  void senMessage({required SendMessageParameters sendMessageParameters}) async {
    getChatLoading = true;
    emit(SendMessageLoadingStates());
    final response = await _chatRemoteDatasource.senMessage(sendMessageParameters: sendMessageParameters);

    response.fold(
      (l) {
        getChatLoading = false;
        emit(SendMessageErrorStates(error: l.baseErrorModel.message));
      },
      (r) {
        getChatLoading = false;
        emit(SendMessageSuccessStates());
      },
    );
  }
}
