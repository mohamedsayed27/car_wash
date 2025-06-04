import 'dart:io';

import 'package:car_wash/core/parameters/auth_parameters/login_parameters.dart';
import 'package:car_wash/data/models/auth_models/register_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/cache_helper/cache_keys.dart';
import '../../core/cache_helper/shared_pref_methods.dart';
import '../../core/network/error_message_model.dart';
import '../../core/parameters/auth_parameters/register_parameters.dart';
import '../../core/parameters/auth_parameters/update_profile_parameters.dart';
import '../../core/services/firebase_messaging_services.dart';
import '../../core/services/services_locator.dart';
import '../../data/data_source/remote_data_source/auth_remote_data_source.dart';
import '../../data/models/auth_models/login_model.dart';
import '../../data/models/notification_model/notification_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRemoteDataSource _authRemoteDataSource = sl();
  final FirebaseMessagingService _firebaseMessagingService = sl();

  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  BaseErrorModel? baseErrorModel;
  LoginModel? loginModel;
  RegisterModel? registerModel;
  final TextEditingController registerFirstNameController =
      TextEditingController();
  final TextEditingController registerLastNameController =
      TextEditingController();
  final TextEditingController registerPhoneController = TextEditingController();
  final TextEditingController registerPasswordController =
      TextEditingController();
  final TextEditingController registerEmailController = TextEditingController();

  String countryDialCode = "20";

  final _picker = ImagePicker();

  File? profileImage;

   TextEditingController loginPhoneController = TextEditingController();
   TextEditingController loginPasswordController = TextEditingController();
  Future<void> getImagePick() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      emit(GetPickedImageSuccessState(pickedImage: File(pickedFile.path)));
    } else {
      emit(GetPickedImageErrorState());
    }
  }

  void login({
    required LoginParameters loginParameters,
  }) async {
    emit(LoginLoadingState());
    final String deviceToke =
        await _firebaseMessagingService.getDeviceToken() ?? "";
    final response = await _authRemoteDataSource.login(
      parameters: LoginParameters(
        deviceToken: deviceToke,
        mobileNumber: "${loginParameters.mobileNumber}",
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

        emit(
          LoginSuccessState(
            loginModel: r,
          ),
        );
      },
    );
  }

  void sendOtp({
    required String code,
    required String token,
  }) async {
    emit(SendOtpLoadingState());
    print(code);
    print(token);
    final response = await _authRemoteDataSource.sendOtp(
      otpCode: code, token: token,
    );
    response.fold(
      (l) {
        print(l);
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
        print("loginModelloginModelloginModelloginModel");
        print(loginModel);
        handleCache(
          token: loginModel?.token,
          userId: loginModel?.result?.id,
          name: loginModel?.result?.name,
          email: loginModel?.result?.email,
          phone: loginModel?.result?.mobile.toString(), userType: loginModel?.result?.type?.toLowerCase(),
        );
        emit(
          SendOtpSuccessState(),
        );
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
        print(l);
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
        emit(
          RegisterSuccessState(
            loginModel: r,
          ),
        );
      },
    );
  }

  bool updateProfileLoading = false;

  void updateProfileData({
    required UpdateProfileParameters updateProfileParameters,
  }) async {
    updateProfileLoading = true;
    emit(UpdateProfileLoadingState());

    final response = await _authRemoteDataSource.updateProfileData(
      parameters: updateProfileParameters,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        updateProfileLoading = false;
        emit(
          UpdateProfileErrorState(
            error: l.baseErrorModel.errors != null
                ? baseErrorModel!.errors![0]
                : l.baseErrorModel.message ?? "",
          ),
        );
      },
      (r) async {
        updateProfileLoading = false;
        emit(UpdateProfileSuccessState());
      },
    );
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? image;
  bool getUserDataLoading = false;

  void getUserData() async {
    getUserDataLoading = true;
    emit(GetUserDataLoadingState());

    final response = await _authRemoteDataSource.getUserData();
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getUserDataLoading = false;
        emit(
          GetUserDataErrorState(
            error: l.baseErrorModel.errors != null
                ? baseErrorModel!.errors![0]
                : l.baseErrorModel.message ?? "",
          ),
        );
      },
      (r) async {
        getUserDataLoading = false;
        emailController = TextEditingController(text: r.result?.email ?? "");
        nameController = TextEditingController(text: r.result?.name ?? "");
        phoneController = TextEditingController(

            text: r.result?.mobile ?? "",
        );
        image = r.result?.avatar;
        emit(GetUserDataSuccessState());
      },
    );
  }
  bool getNotificationsLoading = false;
  List<NotificationItem> notifications= [];
  void getNotifications() async {
    getNotificationsLoading = true;
    emit(GetUserDataLoadingState());

    final response = await _authRemoteDataSource.getNotifications();
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getNotificationsLoading = false;
        emit(
          GetUserDataErrorState(
            error: l.baseErrorModel.errors != null
                ? baseErrorModel!.errors![0]
                : l.baseErrorModel.message ?? "",
          ),
        );
      },
      (r) async {


        getNotificationsLoading = false;
        notifications = r.result??[];

        emit(GetUserDataSuccessState());
      },
    );
  }

  void handleCache({
    required String? token,
    required String? name,
    required String? email,
    required String? phone,
    required String? userType,
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
    await CacheHelper.saveData(
      key: CacheKeys.name,
      value: name,
    );
    await CacheHelper.saveData(
      key: CacheKeys.email,
      value: email,
    );
    await CacheHelper.saveData(
      key: CacheKeys.userType,
      value: userType,
    );
    await CacheHelper.saveData(
      key: CacheKeys.phone,
      value: phone,
    );
    token = CacheHelper.getData(
      key: CacheKeys.token,
    );
    userId = CacheHelper.getData(
      key: CacheKeys.userId,
    );
    name = CacheHelper.getData(
      key: CacheKeys.name,
    );
    email = CacheHelper.getData(
      key: CacheKeys.email,
    );
    phone = CacheHelper.getData(
      key: CacheKeys.phone,
    );
  }
}
