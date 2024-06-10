part of 'chat_cubit.dart';

sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class GetChatLoadingStates extends ChatState {}
final class GetChatSuccessStates extends ChatState {

}
final class GetChatErrorStates extends ChatState {
  final String? error;

  GetChatErrorStates({this.error,});
}
final class GetConversationLoadingStates extends ChatState {}
final class GetConversationSuccessStates extends ChatState {

}
final class GetConversationErrorStates extends ChatState {
  final String? error;

  GetConversationErrorStates({this.error,});
}
final class SendMessageLoadingStates extends ChatState {}
final class SendMessageSuccessStates extends ChatState {

}
final class SendMessageErrorStates extends ChatState {
  final String? error;

  SendMessageErrorStates({this.error,});
}