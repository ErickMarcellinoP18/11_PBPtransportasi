import 'dart:typed_data';
import 'dart:convert';

class LoginModel {
  final int status;
  final String message;
  final User data;

  const LoginModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginModel.fromRawJson(String str) =>
      LoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        data: User.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class User {
  final int? id;

  String? name, email, password, noTelp, fullName;
  Uint8List? profilePicture;

  User(
      {this.id,
      this.name,
      this.email,
      this.fullName,
      this.noTelp,
      this.password,
      this.profilePicture});

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));
  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      fullName: json["fullName"],
      noTelp: json["noTelp"],
      password: json["password"],
      profilePicture: base64Decode(json["profilePicture"]));

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "fullName": fullName,
        "noTelp": noTelp,
        "password": password,
        "profilePicture": base64Encode(profilePicture ?? Uint8List(0)),
      };
}
