import 'package:griha/app/components/transaction_card.dart';
import 'package:griha/app/modules/home/controllers/home_controller.dart';
import 'package:griha/app/modules/profile/controllers/profile_controller.dart';
import 'package:griha/app/utils/assets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../controllers/bookings_controller.dart';

class BookingsView extends GetView<BookingsController> {
  const BookingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(BookingsController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.w,
            vertical: 5.w,
          ),
          child: Obx(
            () => DefaultTabController(
              initialIndex: controller.initialIndex.value,
              length: 2,
              child: Column(
                children: [
                  TabBar(tabs: [
                    Tab(
                      child: Text(
                        'Bookings',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'My Bookings',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 5.h,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                width: 70.w,
                                child: Text(
                                  'This section shows all booking on your propery!',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              GetBuilder<BookingsController>(
                                id: 'bookingRequests',
                                builder: (controller) {
                                  if (controller.bookingRequests == null) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  if (controller
                                      .bookingRequests!.value.isEmpty) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        SizedBox(
                                          height: 50.h,
                                          child:
                                              Lottie.asset(Assets.noFavLottie),
                                        ),
                                        Center(
                                          child: SizedBox(
                                            width: 60.w,
                                            child: Text(
                                              'You haven\'t receive any bookings!',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: controller
                                          .bookingRequests!.value.length,
                                      itemBuilder: (context, index) {
                                        return TransactionCard(
                                            booking: controller
                                                .bookingRequests!.value[index]);
                                      });
                                },
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                width: 70.w,
                                child: Text(
                                  'This section shows all booking mady by you!',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              GetBuilder<BookingsController>(
                                id: 'myBookings',
                                builder: (controller) {
                                  if (controller.myBookings == null) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  if (controller.myBookings!.value.isEmpty) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        SizedBox(
                                          height: 50.h,
                                          child:
                                              Lottie.asset(Assets.noFavLottie),
                                        ),
                                        Center(
                                          child: SizedBox(
                                            width: 60.w,
                                            child: Text(
                                              'You haven\'t made any bookings!',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          controller.myBookings!.value.length,
                                      itemBuilder: (context, index) {
                                        return TransactionCard(
                                          booking: controller
                                              .myBookings!.value[index],
                                        );
                                      });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
