import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:equatable/equatable.dart';

class RegisterParameters extends Equatable {
  final String name;
  final String mobileNumber;
  final String password;
  final File? avatar;

  const RegisterParameters({
    required this.name,
    required this.mobileNumber,
    required this.password,
    required this.avatar,
  });

  Future<Map<String, dynamic>> toJson() async {
    return {
      "name": name,
      "mobile_number": mobileNumber,
      "password": password,
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
    mobileNumber,
    password,
    avatar,
  ];
}
