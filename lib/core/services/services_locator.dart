import 'package:get_it/get_it.dart';

import '../../data/data_source/remote_data_source/auth_remote_data_source.dart';
import '../network/dio_helper.dart';
import 'firebase_messaging_services.dart';
var sl = GetIt.instance;

class ServicesLocators{
  void init(){
    ///DATA SOURCE
    sl.registerLazySingleton(() => AuthRemoteDataSource(dioHelper:sl(),),);

    /// Firebase Messaging
    sl.registerLazySingleton(() =>FirebaseMessagingService(),);
    /// API Methods Class (DIO)
    sl.registerLazySingleton(() => DioHelper());
  }
}