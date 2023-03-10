// To parse this JSON data, do
//
//     final posts = postsFromJson(jsonString);

import 'dart:convert';

List<Posts> postsFromJson(String str) =>
    List<Posts>.from(json.decode(str).map((x) => Posts.fromJson(x)));

String postsToJson(List<Posts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Posts {
  Posts({
    this.postId,
    this.title,
    this.description,
    this.price,
    this.totalRooms,
    this.totalBedroom,
    this.numberOfKitchen,
    this.facilities,
    this.streetAddress,
    this.postedBy,
    this.categoryTitle,
    this.categoryImage,
    this.cityName,
    this.fullname,
    this.phoneNumber,
    this.email,
    this.pictureUrls,
  });

  int? postId;
  String? title;
  String? description;
  int? price;
  int? totalRooms;
  int? totalBedroom;
  int? numberOfKitchen;
  String? facilities;
  String? streetAddress;
  int? postedBy;
  String? categoryTitle;
  String? categoryImage;
  String? cityName;
  String? fullname;
  String? phoneNumber;
  String? email;
  List<String>? pictureUrls;

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        postId: json["post_id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        totalRooms: json["total_rooms"],
        totalBedroom: json["total_bedroom"],
        numberOfKitchen: json["number_of_kitchen"],
        facilities: json["facilities"],
        streetAddress: json["street_address"],
        postedBy: json["posted_by"],
        categoryTitle: json["category_title"],
        categoryImage: json["category_image"],
        cityName: json["city_name"],
        fullname: json["fullname"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        pictureUrls: json["picture_urls"] == null
            ? []
            : List<String>.from(json["picture_urls"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "post_id": postId,
        "title": title,
        "description": description,
        "price": price,
        "total_rooms": totalRooms,
        "total_bedroom": totalBedroom,
        "number_of_kitchen": numberOfKitchen,
        "facilities": facilities,
        "street_address": streetAddress,
        "posted_by": postedBy,
        "category_title": categoryTitle,
        "category_image": categoryImage,
        "city_name": cityName,
        "fullname": fullname,
        "phone_number": phoneNumber,
        "email": email,
        "picture_urls": pictureUrls == null
            ? []
            : List<dynamic>.from(pictureUrls!.map((x) => x)),
      };
}
