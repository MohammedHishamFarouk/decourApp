import 'package:decourapp/data/core/api/end_points.dart';

class GetUserDataModel{
  final String email;
  final String password;
  final String name;
  final String avatar;
  final int id;

  GetUserDataModel({
    required this.email,
    required this.password,
    required this.name,
    required this.avatar,
    required this.id,
   });

  factory GetUserDataModel.fromJson(Map<String,dynamic>jsonData){
    return GetUserDataModel(
      email: jsonData[ApiKey.email],
      password: jsonData[ApiKey.password],
      name: jsonData[ApiKey.name],
      avatar: jsonData[ApiKey.avatar],
      id: jsonData[ApiKey.id],
    );
  }
}