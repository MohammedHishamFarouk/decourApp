import 'package:decourapp/data/core/api/end_points.dart';

class SignInModel{
  final String accessToken;
  final String refreshToken;

  SignInModel({required this.accessToken,required this.refreshToken});

  factory SignInModel.fromJson(Map<String,dynamic>jsonData){
    return SignInModel(
        accessToken: jsonData[ApiKey.accessToken],
        refreshToken: jsonData[ApiKey.refreshToken]);
  }
}