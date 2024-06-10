import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:path/path.dart' as path;
class UpdateProfileParameters extends Equatable {
  final String name;
  final String email;
  final String phone;
  final File? avatar;

  const UpdateProfileParameters({
    required this.name,
    required this.email,
    required this.avatar,
    required this.phone,
  });

  Future<Map<String, dynamic>> toJson() async{
    print(avatar);
   return {
     "name":name,
     "mobile_number":phone,
     "email":email,
     if(avatar!=null)"avatar": await MultipartFile.fromFile(
       avatar!.path,
       filename: path.basename(avatar!.path),
     ),
   };
  }
  @override
  // TODO: implement props
  List<Object?> get props => [
    name,
    email,
    phone,
  ];
}
