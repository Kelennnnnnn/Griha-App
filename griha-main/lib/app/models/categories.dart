// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

Categories categoriesFromJson(String str) =>
    Categories.fromJson(json.decode(str));

String categoriesToJson(Categories data) => json.encode(data.toJson());

class Categories {
  Categories({
    this.data,
    this.message,
    this.success,
  });

  List<Category>? data;
  String? message;
  bool? success;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        data: json["data"] == null
            ? []
            : List<Category>.from(
                json["data"]!.map((x) => Category.fromJson(x))),
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

class Category {
  Category({
    this.categoryId,
    this.title,
    this.imageUrl,
  });

  int? categoryId;
  String? title;
  String? imageUrl;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"],
        title: json["title"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "title": title,
        "image_url": imageUrl,
      };
}
