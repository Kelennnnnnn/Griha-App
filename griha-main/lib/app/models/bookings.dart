// To parse this JSON data, do
//
//     final bookings = bookingsFromJson(jsonString);

import 'dart:convert';

List<Bookings> bookingsFromJson(String str) =>
    List<Bookings>.from(json.decode(str).map((x) => Bookings.fromJson(x)));

String bookingsToJson(List<Bookings> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bookings {
  Bookings({
    this.bookingId,
    this.postId,
    this.userId,
    this.startDate,
    this.endDate,
    this.totalAmount,
    this.isPaid,
    this.paymentMode,
    this.additionalPaymentData,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.description,
    this.price,
    this.totalRooms,
    this.totalBedroom,
    this.numberOfKitchen,
    this.facilities,
    this.streetAddress,
    this.postedBy,
  });

  int? bookingId;
  int? postId;
  int? userId;
  DateTime? startDate;
  DateTime? endDate;
  int? totalAmount;
  int? isPaid;
  String? paymentMode;
  String? additionalPaymentData;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? title;
  String? description;
  int? price;
  int? totalRooms;
  int? totalBedroom;
  int? numberOfKitchen;
  String? facilities;
  String? streetAddress;
  int? postedBy;

  factory Bookings.fromJson(Map<String, dynamic> json) => Bookings(
        bookingId: json["booking_id"],
        postId: json["post_id"],
        userId: json["user_id"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        totalAmount: json["total_amount"],
        isPaid: json["is_paid"],
        paymentMode: json["payment_mode"],
        additionalPaymentData: json["additional_payment_data"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        title: json["title"],
        description: json["description"],
        price: json["price"],
        totalRooms: json["total_rooms"],
        totalBedroom: json["total_bedroom"],
        numberOfKitchen: json["number_of_kitchen"],
        facilities: json["facilities"],
        streetAddress: json["street_address"],
        postedBy: json["posted_by"],
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "post_id": postId,
        "user_id": userId,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "total_amount": totalAmount,
        "is_paid": isPaid,
        "payment_mode": paymentMode,
        "additional_payment_data": additionalPaymentData,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "title": title,
        "description": description,
        "price": price,
        "total_rooms": totalRooms,
        "total_bedroom": totalBedroom,
        "number_of_kitchen": numberOfKitchen,
        "facilities": facilities,
        "street_address": streetAddress,
        "posted_by": postedBy,
      };
}
