import 'package:car_wash/core/cache_helper/cache_keys.dart';
import 'package:car_wash/core/cache_helper/shared_pref_methods.dart';
import 'package:car_wash/core/constants/constants.dart';
import 'package:dio/dio.dart';
import 'api_end_points.dart';

class DioHelper {
  static late Dio dio;

   static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  void getToken(){

    token = CacheHelper.getData(key: CacheKeys.token);
  }
   Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
  }) async {
     getToken();
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': '',
      'User-Agent': 'Chrome/96.0.4664.110',
      if (token != null) "Authorization": "Bearer $token",
      'Accept': 'text/plain',
    };
    return await dio.get(url, queryParameters: query,);
  }

   Future<Response> postData({
    required String url,
    dynamic query,
    dynamic data,
    String lang = 'en',
    Options? options,
  }) async {

     getToken();
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': '',
      'User-Agent': 'Chrome/96.0.4664.110',
      if (token != null) "Authorization": "Bearer $token",
      'Accept': 'text/plain',
    };
    return await dio.post(url, queryParameters: query, data: data,options: options);

    // return ;
  }

   Future<Response> deleteData({
    required String url,
    dynamic query,
    dynamic data,
    String lang = 'en',
  }) async {
     getToken();
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': '',
      'User-Agent': 'Chrome/96.0.4664.110',
      if (token != null) "Authorization": "Bearer $token",
      'Accept': 'text/plain',
    };
    return await dio.delete(url, queryParameters: query, data: data);
  }

   Future<Response> putData({
    required String url,
    dynamic query,
    dynamic data,
    String lang = 'en',
  }) async {
     getToken();
    dio.options.headers = {
      'Content-Type': 'application/json',
      'User-Agent': 'Chrome/96.0.4664.110',
      if (token != null) "Authorization": "Bearer $token",
      'Accept': 'text/plain',
    };
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
