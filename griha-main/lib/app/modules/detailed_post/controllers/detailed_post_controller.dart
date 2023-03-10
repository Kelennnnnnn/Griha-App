import 'dart:convert';
import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:griha/app/components/custom_textButton.dart';
import 'package:griha/app/models/api_response.dart';
import 'package:griha/app/modules/booking/controllers/bookings_controller.dart';
import 'package:griha/app/utils/colors.dart';
import 'package:griha/app/utils/constants.dart';
import 'package:griha/app/utils/memory_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:sizer/sizer.dart';

class DetailedPostController extends GetxController {
  //TODO: Implement DetailedPostController
  CarouselController carouselController = CarouselController();
  Rx<DateTimeRange?> dateTimeRange = Rx<DateTimeRange?>(null);
  Rx<bool> showBooking = true.obs;
  PageController pageController = PageController(initialPage: 0);
  Rx<bool> isLoading = false.obs;
  BookingsController bookingsController = Get.put(BookingsController());

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void makeBooking(
      {required String postId,
      required String amount,
      required String postName}) async {
    try {
      final config = PaymentConfig(
        amount: 1000,
        // amount: int.parse(amount) * 100, // Amount should be in paisa
        productIdentity: postId,
        productName: postName,
      );
      if (!await checkBooking(
          postId: postId, totalAmount: amount, isPaid: false)) {
        return;
      } else {
        showDialog(
            context: Get.context!,
            builder: (context) => Center(
                    child: Dialog(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.5.w,
                      vertical: 5.w,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Text(
                            'Select payment option',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.w,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await onPayWithKhalti(config);
                          },
                          child: SvgPicture.asset(
                            'assets/images/khalti.svg',
                            height: 5.h,
                            width: 5.h,
                          ),
                        ),
                        SizedBox(
                          height: 10.w,
                        ),
                        Obx(
                          () => CustomButton(
                            title: 'Pay on Arrival',
                            color: Colors.green.shade500,
                            isLoading: isLoading.value,
                            onPressed: () async {
                              await book(
                                  postId: postId,
                                  totalAmount: (config.amount).toString(),
                                  isPaid: false,
                                  paymentMode: null);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )));
      }
    } on DioError catch (e) {
      showCustomSnackBar(
          message: e.response?.data['message'] ?? "Some thing went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  //make booking
  Future<void> book({
    required String postId,
    required String totalAmount,
    required bool isPaid,
    PaymentMode? paymentMode,
    String? additionalPaymentInfo,
  }) async {
    try {
      isLoading.value = true;
      var res = await services.makeBooking(
        postId: postId,
        date: dateTimeRange.value!,
        totalAmount: totalAmount,
        isPaid: isPaid,
        paymentMode: paymentMode,
        additionalPaymentInfo: additionalPaymentInfo,
      );

      if (res is ApiResponse && res.isSucces) {
        Get.back();

        showCustomSnackBar(message: res.message, milliseconds: 1000);
        await bookingsController.getMyBookings();
        await bookingsController.getBookingRequests();
      } else if (res is ApiResponse && !res.isSucces) {
        showCustomSnackBar(message: res.message, milliseconds: 1000);
      } else {
        showCustomSnackBar(message: 'Something went wrong', milliseconds: 1000);
      }
    } catch (e) {
      showCustomSnackBar(message: 'Something went wrong', milliseconds: 1000);
    } finally {
      isLoading.value = false;
    }
  }

  //make booking
  Future<bool> checkBooking({
    required String postId,
    required String totalAmount,
    required bool isPaid,
  }) async {
    isLoading.value = true;
    var res = await services.checkBooking(
      postId: postId,
      date: dateTimeRange.value!,
      totalAmount: totalAmount,
      isPaid: isPaid,
    );

    if (res is ApiResponse && res.isSucces) {
      return true;
    } else if (res is ApiResponse && !res.isSucces) {
      showCustomSnackBar(message: res.message, milliseconds: 1000);
      return false;
    } else {
      showCustomSnackBar(message: 'Something went wrong', milliseconds: 1000);
      return false;
    }
  }

  Future<void> onPayWithKhalti(PaymentConfig config) async {
    Get.close(1);

    await KhaltiScope.of(Get.context!).pay(
      config: config,
      preferences: [PaymentPreference.khalti],
      onSuccess: (PaymentSuccessModel value) async {
        await book(
          postId: config.productIdentity,
          totalAmount: config.amount.toString(),
          isPaid: true,
          paymentMode: PaymentMode.khalti,
          additionalPaymentInfo: value.toString(),
        );
        print(value.toString());
      },
      onFailure: (value) {
        showCustomSnackBar(message: value.message);
      },
      onCancel: () {
        showCustomSnackBar(message: 'Payment cancelled');
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
