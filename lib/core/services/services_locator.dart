import 'package:car_wash/data/data_source/remote_data_source/address_remote_data_source.dart';
import 'package:car_wash/data/data_source/remote_data_source/orders_remote_data_source.dart';
import 'package:car_wash/data/data_source/remote_data_source/plans_remote_datasource.dart';
import 'package:get_it/get_it.dart';

import '../../data/data_source/remote_data_source/auth_remote_data_source.dart';
import '../../data/data_source/remote_data_source/chat_remote_datasource.dart';
import '../../data/data_source/remote_data_source/pages_remote_data_source.dart';
import '../../data/data_source/remote_data_source/representitive_remote_data_source.dart';
import '../network/dio_helper.dart';
import 'firebase_messaging_services.dart';
var sl = GetIt.instance;

class ServicesLocators{
  void init(){
    ///DATA SOURCE
    sl.registerLazySingleton(() => AuthRemoteDataSource(dioHelper:sl(),),);
    sl.registerLazySingleton(() => AddressRemoteDatasource(dioHelper:sl(),),);
    sl.registerLazySingleton(() => OrdersRemoteDatasource(dioHelper:sl(),),);
    sl.registerLazySingleton(() => PlansRemoteDatasource(dioHelper:sl(),),);
    sl.registerLazySingleton(() => PagesRemoteDataSource(dioHelper:sl(),),);
    sl.registerLazySingleton(() => RepresentativeDatasource(dioHelper:sl(),),);
    sl.registerLazySingleton(() => ChatRemoteDatasource(dioHelper:sl(),),);

    /// Firebase Messaging
    sl.registerLazySingleton(() =>FirebaseMessagingService(),);
    /// API Methods Class (DIO)
    sl.registerLazySingleton(() => DioHelper());
  }
}