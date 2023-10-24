import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  final bool? result;
  final String? token;

  LoginResponseModel({
    this.result,
    this.token,
  });

  factory LoginResponseModel.fromRawJson(String str) => LoginResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    result: json["result"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "token": token,
  };
}