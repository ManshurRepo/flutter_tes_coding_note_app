import 'dart:convert';

class LoginRequestModel {
  final String identifier;
  final String password;

  LoginRequestModel({
    required this.identifier,
    required this.password,
  });

  factory LoginRequestModel.fromJson(String str) =>
      LoginRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginRequestModel.fromMap(Map<String, dynamic> json) =>
      LoginRequestModel(
        identifier: json["identifier"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "identifier": identifier,
        "password": password,
      };
}
