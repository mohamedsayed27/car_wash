part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}


class LoginLoadingState extends AuthState {}
class LoginSuccessState extends AuthState {}
class LoginErrorState extends AuthState {
  final String error;
  LoginErrorState({required this.error});
}