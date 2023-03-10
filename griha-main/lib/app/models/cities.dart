// To parse this JSON data, do
//
//     final cities = citiesFromJson(jsonString);

import 'dart:convert';

Cities citiesFromJson(String str) => Cities.fromJson(json.decode(str));

String citiesToJson(Cities data) => json.encode(data.toJson());

class Cities {
  Cities({
    this.data,
    this.message,
    this.success,
  });

  List<City>? data;
  String? message;
  bool? success;

  factory Cities.fromJson(Map<String, dynamic> json) => Cities(
        data: json["data"] == null
            ? []
            : List<City>.from(json["data"]!.map((x) => City.fromJson(x))),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "success": success,
      };
}

class City {
  City({
    this.cityId,
    this.cityName,
  });

  int? cityId;
  String? cityName;

  factory City.fromJson(Map<String, dynamic> json) => City(
        cityId: json["city_id"],
        cityName: json["city_name"],
      );

  Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "city_name": cityName,
      };
}
