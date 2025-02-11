import 'package:decourapp/data/core/api/end_points.dart';

class SignUpModel{
  final String email;
  final String password;
  final String name;
  final String avatar;
  final String role;
  final int id;
  final String creationAt;
  final String updatedAt;

  SignUpModel({
    required this.email,
    required this.password,
    required this.name,
    required this.avatar,
    required this.role,
    required this.id,
    required this.creationAt,
    required this.updatedAt});

  factory SignUpModel.fromJson(Map<String,dynamic>jsonData){
    return SignUpModel(
        email: jsonData[ApiKey.email],
        password: jsonData[ApiKey.password],
        name: jsonData[ApiKey.name],
        avatar: jsonData[ApiKey.avatar],
        role: jsonData[ApiKey.role],
        id: jsonData[ApiKey.id],
        creationAt: jsonData[ApiKey.creationAt],
        updatedAt: jsonData[ApiKey.updatedAt],
    );
  }
}