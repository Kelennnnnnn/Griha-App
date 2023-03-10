import 'package:flutter/material.dart';
import 'package:griha/app/utils/constants.dart';
import 'package:image_picker/image_picker.dart';

abstract class Services {
  Future login({required String email, required String password});
  Future register(
      {required String email,
      required String fullName,
      required String password,
      required String phoneNumber,
      bool isAdmin = false});
  Future getUserDetails();
  Future updateUserDetails({
    required String name,
    required String phoneNumber,
  });

  Future getCities();
  Future getCategories();
  Future getPosts({bool isMyPosts = false, String? categoryId});

  Future makeBooking(
      {required String postId,
      required DateTimeRange date,
      required String totalAmount,
      required bool isPaid,
      PaymentMode? paymentMode,
      String? additionalPaymentInfo});

  Future checkBooking({
    required String postId,
    required DateTimeRange date,
    required String totalAmount,
    required bool isPaid,
  });

  Future getMyBookings();
  Future getBookingRequests();

  Future deletePost({required String postId});

  Future changePassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  });

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
      required List<XFile> images});
}
