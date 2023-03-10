// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.userId,
    this.fullName,
    this.phoneNumber,
    this.email,
    this.streetAddress,
    this.cityId,
    this.isAdmin,
    this.cityName,
  });

  int? userId;
  String? fullName;
  String? phoneNumber;
  String? email;
  String? streetAddress;
  int? cityId;
  int? isAdmin;
  String? cityName;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        fullName: json["full_name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        streetAddress: json["street_address"],
        cityId: json["city_id"],
        isAdmin: json["is_admin"],
        cityName: json["city_name"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "full_name": fullName,
        "phone_number": phoneNumber,
        "email": email,
        "street_address": streetAddress,
        "city_id": cityId,
        "is_admin": isAdmin,
        "city_name": cityName,
      };
}
