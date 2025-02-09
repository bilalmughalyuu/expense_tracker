import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? email;
  String? password;
  DateTime? timeStamp;

  UserModel({
    this.email,
    this.password,
    this.timeStamp,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"] != null ? json["email"].toString() : "",
        password: json["password"] != null ? json["password"].toString() : "",
        timeStamp: json["timeStamp"] != null
            ? DateTime.parse(json["timeStamp"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "timeStamp": timeStamp?.toIso8601String(),
      };
}
