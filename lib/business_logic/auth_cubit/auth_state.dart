part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}
class GetPickedImageSuccessState extends AuthState {

  final File? pickedImage;

  GetPickedImageSuccessState({required this.pickedImage,});
}


class GetPickedImageErrorState extends AuthState {}

class LoginLoadingState extends AuthState {}
class LoginSuccessState extends AuthState {
  final LoginModel? loginModel;

  LoginSuccessState({required this.loginModel,});
}
class LoginErrorState extends AuthState {
  final String error;
  LoginErrorState({required this.error});
}

class SendOtpLoadingState extends AuthState {}
class SendOtpSuccessState extends AuthState {

  SendOtpSuccessState();
}
class SendOtpErrorState extends AuthState {
  final String error;
  SendOtpErrorState({required this.error});
}

class RegisterLoadingState extends AuthState {}
class RegisterSuccessState extends AuthState {
  final RegisterModel? loginModel;

  RegisterSuccessState({required this.loginModel,});
}
class RegisterErrorState extends AuthState {
  final String error;
  RegisterErrorState({required this.error});
}
class UpdateProfileLoadingState extends AuthState {}
class UpdateProfileSuccessState extends AuthState {}
class UpdateProfileErrorState extends AuthState {
  final String error;
  UpdateProfileErrorState({required this.error});
}

class GetUserDataLoadingState extends AuthState {}
class GetUserDataSuccessState extends AuthState {}
class GetUserDataErrorState extends AuthState {
  final String error;
  GetUserDataErrorState({required this.error});
}