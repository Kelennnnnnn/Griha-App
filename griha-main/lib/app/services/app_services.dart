import 'dart:convert';

import 'package:griha/app/models/bookings.dart';
import 'package:griha/app/utils/constants.dart';
import 'package:flutter/src/material/date.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';
import 'package:griha/app/models/api_response.dart';
import 'package:griha/app/models/categories.dart';
import 'package:griha/app/models/cities.dart';
import 'package:griha/app/models/posts.dart';

import 'package:griha/app/models/user.dart';
import 'package:griha/app/network/api_endpoints.dart';
import 'package:griha/app/network/api_handler.dart';
import 'package:griha/app/services/services.dart';
import 'package:griha/app/utils/memory_management.dart';
import 'package:image_picker/image_picker.dart';

class AppServices implements Services {
  @override
  Future getUserDetails() async {
    final res = await ApiHandler.hitApi(
        dio.get(APIs.getUserDetails + MemoryManagement.getUserId()!));
    if (res is Response && res.statusCode == 200) {
      return User.fromJson(res.data);
    } else {
      return ApiResponse(isSucces: false, message: 'Something went wrong');
    }
  }

  @override
  Future login({required String email, required String password}) async {
    final res = await ApiHandler.hitApi(dio.post(APIs.login, data: {
      "email": email,
      "password": password,
    }));

    var response = res.data;

    if (res is Response && res.statusCode == 200) {
      if (response['is_admin'] == 1) {
        return ApiResponse(isSucces: false, message: 'Login from Admin App');
      } else {
        MemoryManagement.setAccessToken(accessToken: response['token']);
        MemoryManagement.setLoginStatus(status: true);
        return ApiResponse(isSucces: true, message: 'Login Successful');
      }
    } else {}
  }

  @override
  Future getPosts({bool isMyPosts = false, String? categoryId}) async {
    final res =
        await ApiHandler.hitApi(dio.get(APIs.getPosts, queryParameters: {
      "myPosts": isMyPosts ? 'true' : 'false',
      "category": categoryId,
    }));
    if (res is Response && res.statusCode == 200) {
      return postsFromJson(jsonEncode(res.data));
    } else {
      return ApiResponse(isSucces: false, message: 'Something went wrong');
    }
  }

  @override
  Future updateUserDetails({
    required String name,
    required String phoneNumber,
  }) async {
    final res = await ApiHandler.hitApi(
        dio.put(APIs.updateUserDetails + MemoryManagement.getUserId()!, data: {
      "full_name": name,
      "phone_number": phoneNumber,
    }));

    if (res is Response && res.statusCode == 200) {
      return ApiResponse(isSucces: true, message: 'User updated Successfully');
    } else {
      return ApiResponse(
          isSucces: false,
          message: res.data['message'] ?? 'Something went wrong');
    }
  }

  @override
  Future changePassword({
    required String oldPassword,
    required String newPassword,
    required String email,
  }) async {
    final res = await ApiHandler.hitApi(
        dio.put(APIs.changePassword + MemoryManagement.getUserId()!, data: {
      "email": email,
      "password": oldPassword,
      "newPassword": newPassword,
    }));

    if (res is Response && res.statusCode == 200) {
      return ApiResponse(
          isSucces: true, message: 'Password changed successfully');
    } else {
      return ApiResponse(
          isSucces: false,
          message: res.data['message'] ?? 'Something went wrong');
    }
  }

  @override
  Future getCities() async {
    final res = await ApiHandler.hitApi(dio.get(APIs.city));

    if (res is Response && res.statusCode == 200) {
      return Cities.fromJson(res.data);
    } else {
      return ApiResponse(isSucces: false, message: 'Something went wrong');
    }
  }

  @override
  Future getCategories() async {
    final res = await ApiHandler.hitApi(dio.get(APIs.category));

    if (res is Response && res.statusCode == 200) {
      return Categories.fromJson(res.data);
    } else {
      return ApiResponse(isSucces: false, message: 'Something went wrong');
    }
  }

  @override
  Future register(
      {required String email,
      required String fullName,
      required String password,
      required String phoneNumber,
      bool isAdmin = false}) async {
    final res = await ApiHandler.hitApi(dio.post(APIs.register, data: {
      "email": email,
      "fullName": fullName,
      "password": password,
      "phoneNumber": phoneNumber,
    }));

    if (res is Response && res.statusCode == 200) {
      return ApiResponse(
          isSucces: true, message: 'User registered successfully!');
    } else {
      return ApiResponse(isSucces: false, message: 'Something went wrong');
    }
  }

  @override
  Future addPost(
      {required int categoryId,
      required int cityId,
      required String title,
      required String description,
      required String price,
      required String totalRooms,
      required String totalBedrooms,
      required String numberOfKitchen,
      required String facilities,
      required String streetAddress,
      required List<XFile> images}) async {
    List<MultipartFile> imageFiles = [];

    for (int i = 0; i < images.length; i++) {
      String imagePath = images[i].path;
      String originalFileName = path.basename(imagePath);
      String fileName = generateUniqueFileName(originalFileName);

      MultipartFile imageFile =
          await MultipartFile.fromFile(imagePath, filename: fileName);
      imageFiles.add(imageFile);
    }

    var formData = FormData.fromMap({
      "category_id": categoryId,
      "city_id": cityId,
      "title": title,
      "description": description,
      "price": price,
      "total_rooms": totalRooms,
      "total_bedroom": totalBedrooms,
      "number_of_kitchen": numberOfKitchen,
      "facilities": facilities,
      "street_address": streetAddress,
      "images": imageFiles
    });
    final res = await ApiHandler.hitApi(dio.post(
        APIs.post(userId: MemoryManagement.getUserId().toString()),
        data: formData));

    if (res.statusCode == 200) {
      return ApiResponse(isSucces: true, message: 'Post added successfully!');
    } else {
      return ApiResponse(isSucces: false, message: 'Something went wrong');
    }
  }

  @override
  Future makeBooking(
      {required String postId,
      required DateTimeRange date,
      required String totalAmount,
      required bool isPaid,
      PaymentMode? paymentMode,
      String? additionalPaymentInfo}) async {
    var formData = FormData.fromMap({
      "post_id": postId,
      "start_date": date.start.toString(),
      "end_date": date.end.toString(),
      "total_amount": totalAmount,
      "is_paid": isPaid,
      "payment_mode": paymentMode?.name,
      "additional_payment_data": additionalPaymentInfo,
    });

    final res = await ApiHandler.hitApi(
      dio.post(
        APIs.makeBooking(userId: MemoryManagement.getUserId().toString()),
        data: formData,
      ),
    );

    if (res is Response && res.statusCode == 200) {
      return ApiResponse(isSucces: true, message: 'Booking made successfully!');
    } else {
      return ApiResponse(isSucces: false, message: 'Something went wrong');
    }
  }

  @override
  Future checkBooking({
    required String postId,
    required DateTimeRange date,
    required String totalAmount,
    required bool isPaid,
  }) async {
    var formData = FormData.fromMap({
      "post_id": postId,
      "start_date": date.start.toString(),
      "end_date": date.end.toString(),
      "total_amount": totalAmount,
      "is_paid": false,
    });

    final res = await ApiHandler.hitApi(
      dio.post(
        APIs.checkBooking(userId: MemoryManagement.getUserId().toString()),
        data: formData,
      ),
    );

    if (res is Response && res.statusCode == 200) {
      return ApiResponse(isSucces: true, message: 'Booking made successfully!');
    } else {
      return ApiResponse(isSucces: false, message: 'Something went wrong');
    }
  }

  @override
  Future getBookingRequests() async {
    final res = await ApiHandler.hitApi(dio
        .get(APIs.getBookingRequests(userId: MemoryManagement.getUserId()!)));
    if (res is Response && res.statusCode == 200) {
      return bookingsFromJson(jsonEncode(res.data));
    } else {
      return ApiResponse(isSucces: false, message: 'Something went wrong');
    }
  }

  @override
  Future getMyBookings() async {
    final res = await ApiHandler.hitApi(
        dio.get(APIs.getMyBookings(userId: MemoryManagement.getUserId()!)));
    if (res is Response && res.statusCode == 200) {
      return bookingsFromJson(jsonEncode(res.data));
    } else {
      return ApiResponse(isSucces: false, message: 'Something went wrong');
    }
  }

  @override
  Future deletePost({required String postId}) async {
    final res =
        await ApiHandler.hitApi(dio.delete(APIs.deletePost(postId: postId)));
    if (res is Response && res.statusCode == 200) {
      return ApiResponse(isSucces: true, message: 'Post deleted successfully!');
    } else {
      return ApiResponse(isSucces: false, message: 'Something went wrong');
    }
  }
}
