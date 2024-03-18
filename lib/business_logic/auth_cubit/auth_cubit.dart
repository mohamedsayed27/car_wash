import 'package:car_wash/core/parameters/auth_parameters/login_parameters.dart';
import 'package:car_wash/data/models/auth_models/register_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cache_helper/cache_keys.dart';
import '../../core/cache_helper/shared_pref_methods.dart';
import '../../core/network/error_message_model.dart';
import '../../core/parameters/auth_parameters/register_parameters.dart';
import '../../core/services/firebase_messaging_services.dart';
import '../../core/services/services_locator.dart';
import '../../data/data_source/remote_data_source/auth_remote_data_source.dart';
import '../../data/models/auth_models/login_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRemoteDataSource _authRemoteDataSource = sl();
  final FirebaseMessagingService _firebaseMessagingService = sl();

  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  BaseErrorModel? baseErrorModel;
  LoginModel? loginModel;
  RegisterModel? registerModel;
  final TextEditingController loginPhoneController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();


  void login({
    required LoginParameters loginParameters,
  }) async {
    emit(LoginLoadingState());
    final String deviceToke =
        await _firebaseMessagingService.getDeviceToken() ?? "";
    final response = await _authRemoteDataSource.login(
      parameters: LoginParameters(
        deviceToken: deviceToke,
        mobileNumber: "0${loginParameters.mobileNumber}",
        password: loginParameters.password,
      ),
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(
          LoginErrorState(
            error: l.baseErrorModel.errors != null
                ? baseErrorModel!.errors![0]
                : l.baseErrorModel.message ?? "",
          ),
        );
      },
      (r) async {
        loginModel = r;

        emit(LoginSuccessState(loginModel: r,),);
      },
    );
  }


  void sendOtp({
    required String code,
  }) async {
    emit(SendOtpLoadingState());
    final response = await _authRemoteDataSource.sendOtp(
      otpCode: code,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(
          SendOtpErrorState(
            error: l.baseErrorModel.errors != null
                ? baseErrorModel!.errors![0]
                : l.baseErrorModel.message ?? "",
          ),
        );
      },
      (r) async {
        handleCache(
          token: loginModel?.token ,
          userId: loginModel?.result?.id ,
        );
        emit(SendOtpSuccessState(),);
      },
    );
  }

  void register({
    required RegisterParameters registerParameters,
  }) async {
    emit(RegisterLoadingState());

    final response = await _authRemoteDataSource.register(
      parameters: RegisterParameters(
        name: registerParameters.name,
        mobileNumber: registerParameters.mobileNumber,
        password: registerParameters.password,
        avatar: registerParameters.avatar,
      ),
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(
          RegisterErrorState(
            error: l.baseErrorModel.errors != null
                ? baseErrorModel!.errors![0]
                : l.baseErrorModel.message ?? "",
          ),
        );
      },
      (r) async {
        registerModel = r;
        handleCache(
          token: r.token ,
          userId: r.result!.id ,
        );
        emit(RegisterSuccessState(loginModel: r,),);
      },
    );
  }

  void handleCache({
    required String? token,
    required int? userId,
  }) async {
    await CacheHelper.saveData(
      key: CacheKeys.token,
      value: token,
    );
    await CacheHelper.saveData(
      key: CacheKeys.userId,
      value: userId,
    );
    token = CacheHelper.getData(
      key: CacheKeys.token,
    );
    userId = CacheHelper.getData(
      key: CacheKeys.userId,
    );
  }
}
