import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static late SharedPreferences sharedPreferences;

  static init()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static dynamic getData({required String key}){
    return sharedPreferences.get(key);
  }
  static bool? getBoolean(
      {
        required String key,

      }) {
    return sharedPreferences.getBool(key);
  }
  static Future<bool?> saveData({required String key , required dynamic value})
  async {
    if(value!=null){
      if(value is String) return await sharedPreferences.setString(key, value);
      if(value is bool) return await sharedPreferences.setBool(key,value );
      if(value is int) return await sharedPreferences.setInt(key, value);
      return await sharedPreferences.setDouble(key, value);
    }else{
      return await null;
    }



  }


  static Future<bool> removeData({required key})async{
    return await sharedPreferences.remove(key);
  }


  static Future<bool> clearAllCache()async{
    return await sharedPreferences.clear();
  }
}