import 'package:car_wash/core/parameters/auth_parameters/login_parameters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cache_helper/cache_keys.dart';
import '../../core/cache_helper/shared_pref_methods.dart';
import '../../core/constants/constants.dart';
import '../../core/network/error_message_model.dart';
import '../../core/parameters/auth_parameters/register_parameters.dart';
import '../../core/services/firebase_messaging_services.dart';
import '../../core/services/services_locator.dart';
import '../../data/data_source/remote_data_source/auth_remote_data_source.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRemoteDataSource authRemoteDataSource = sl();
  final FirebaseMessagingService firebaseMessagingService = sl();

  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  BaseErrorModel? baseErrorModel;

  void login({
    required LoginParameters loginParameters,
  }) async {
    emit(LoginLoadingState());
    final String deviceToke =
        await firebaseMessagingService.getDeviceToken() ?? "";
    final response = await authRemoteDataSource.login(
      parameters: LoginParameters(
        deviceToken: deviceToke,
        mobileNumber: loginParameters.mobileNumber,
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
        handleCache(
          token: r.token ,
          userId: r.result!.id ,
        );
        emit(LoginSuccessState());
      },
    );
  }

  void register({
    required RegisterParameters registerParameters,
  }) async {
    emit(LoginLoadingState());

    final response = await authRemoteDataSource.register(
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
          LoginErrorState(
            error: l.baseErrorModel.errors != null
                ? baseErrorModel!.errors![0]
                : l.baseErrorModel.message ?? "",
          ),
        );
      },
      (r) async {
        handleCache(
          token: r.token ,
          userId: r.result!.id ,
        );
        emit(LoginSuccessState());
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
