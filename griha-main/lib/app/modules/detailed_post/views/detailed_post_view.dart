import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:griha/app/components/custom_textButton.dart';
import 'package:griha/app/models/item_model.dart';
import 'package:griha/app/models/posts.dart';
import 'package:griha/app/utils/assets.dart';
import 'package:griha/app/utils/colors.dart';
import 'package:griha/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:griha/app/utils/memory_management.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/detailed_post_controller.dart';

class DetailedPostView extends GetView<DetailedPostController> {
  const DetailedPostView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    gap({double? height, double? width}) => SizedBox(
          height: height ?? 3.w,
          width: width ?? 5.w,
        );
    Posts posts = Get.arguments;
    var facilities = jsonDecode(posts.facilities ?? '');

    List<String> facilitiesList =
        facilities.map<String>((e) => e.toString()).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 100.w,
                child: CarouselSlider.builder(
                  carouselController: controller.carouselController,
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    padEnds: false,
                    pageSnapping: true,
                    viewportFraction: 1,
                    enlargeFactor: 0.3,
                    pauseAutoPlayInFiniteScroll: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlay: true,
                  ),
                  itemCount: posts.pictureUrls?.length ?? 0,
                  itemBuilder: ((context, index, realIndex) {
                    return Stack(
                      children: [
                        Hero(
                          tag: 'postImage',
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.w),
                            ),
                            height: 50.w,
                            width: 94.w,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2.w),
                              child: CachedNetworkImage(
                                imageUrl:
                                    getImageUrl(posts.pictureUrls?[index]),
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 70.w,
                          child: Text(
                            posts.title ?? '',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        // SizedBox(
                        //   height: 7.w,
                        //   width: 7.w,
                        //   child: SvgPicture.asset(
                        //     'assets/images/heart_icon.svg',
                        //     color: textFieldHintColor,
                        //   ),
                        // ),
                      ],
                    ),
                    gap(height: 1.w),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: textFieldHintColor,
                          size: 15,
                        ),
                        gap(width: 1.w),
                        Text(
                          '${posts.streetAddress}, ${posts.cityName}',
                          style: TextStyle(
                            fontSize: 12.5.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            color: textFieldHintColor,
                          ),
                        ),
                      ],
                    ),
                    gap(height: 5.w),
                    Row(
                      children: [
                        getProfile(posts.fullname ?? '', radius: 5.w),
                        gap(width: 3.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              posts.fullname ?? '',
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            gap(height: 0.5.w),
                            Text(
                              'Property Owner',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                color: textFieldHintColor,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () async {
                            Uri uri = Uri(
                              scheme: 'sms',
                              path: posts.phoneNumber ?? '',
                              queryParameters: {
                                'subject': 'Regarding your property',
                              },
                            );
                            await launchUrl(uri);
                          },
                          child: Container(
                            height: 11.w,
                            width: 11.w,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2.5.w),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 3,
                                    blurRadius: 3,
                                    offset: const Offset(
                                        0, 0), // changes position of shadow
                                  ),
                                ]),
                            child: const Icon(
                              Icons.chat,
                              color: textFieldHintColor,
                            ),
                          ),
                        ),
                        gap(width: 5.w),
                        InkWell(
                          onTap: () async {
                            Uri uri = Uri(
                              scheme: 'tel',
                              path: posts.phoneNumber ?? '',
                            );
                            await launchUrl(uri);
                          },
                          child: Container(
                            height: 11.w,
                            width: 11.w,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2.5.w),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 3,
                                    blurRadius: 3,
                                    offset: const Offset(
                                        0, 0), // changes position of shadow
                                  ),
                                ]),
                            child: const Icon(
                              Icons.call,
                              color: textFieldHintColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    gap(height: 7.w),
                    SizedBox(
                      child: Text(
                        posts.description ?? '',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: textFieldHintColor,
                        ),
                      ),
                    ),
                    gap(height: 7.w),
                    Row(
                      children: [
                        Text(
                          'Home Facilities',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: facilitiesList.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 12.w,
                            child: ListTile(
                              title: Text(facilitiesList[index]),
                            ),
                          );
                        })
                  ],
                ),
              ),
            ],
          ),
          Obx(
            () => controller.dateTimeRange.value == null
                ? const SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                    ),
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.h,
                            width: double.infinity,
                            child: Lottie.asset(Assets.bookingLottie),
                          ),
                          gap(height: 5.w),
                          Center(
                            child: Text(
                              'Your booking information',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          gap(height: 5.w),
                          Row(
                            children: [
                              Text(
                                'Check-in:',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              gap(),
                              Text(
                                  '${DateFormat('dd MMM yyyy').format(controller.dateTimeRange.value!.start)}, ${DateFormat('EE').format(controller.dateTimeRange.value!.start)}',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Poppins',
                                    color: Colors.blueGrey,
                                  )),

                              const Spacer(),
                              // Text(
                              //   'Check-out',
                              //   style: TextStyle(
                              //     fontSize: 12.sp,
                              //     fontWeight: FontWeight.w500,
                              //     fontFamily: 'Poppins',
                              //   ),
                              // ),
                            ],
                          ),
                          gap(height: 5.w),
                          Row(
                            children: [
                              Text(
                                'Check-out:',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              gap(),
                              Text(
                                  '${DateFormat('dd MMM yyyy').format(controller.dateTimeRange.value!.end)}, ${DateFormat('EE').format(controller.dateTimeRange.value!.end)}',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Poppins',
                                  )),
                            ],
                          ),
                          gap(height: 5.w),
                          Row(
                            children: [
                              Text(
                                'Property details:',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          gap(height: 5.w),
                          Row(
                            children: [
                              Text(
                                'Property name:',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              gap(),
                              Text(
                                posts.title ?? '',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          gap(height: 5.w),
                          Row(
                            children: [
                              Text(
                                'Property type:',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              gap(),
                              Text(
                                posts.categoryTitle ?? '',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          gap(),
                          Text(
                            'Per Day charge: Rs.${posts.price ?? ''}',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          gap(),
                          Text(
                            'Total Days: ${controller.dateTimeRange.value!.duration.inDays}',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          gap(height: 10.w),
                          Row(
                            children: [
                              Text(
                                'Your total amount is: ',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Rs.${posts.price! * controller.dateTimeRange.value!.duration.inDays}',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: Colors.blue,
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                          Obx(() => CustomButton(
                                title: 'Confirm Booking',
                                isLoading: controller.isLoading.value,
                                onPressed: () {
                                  controller.makeBooking(
                                      postId: posts.postId.toString(),
                                      postName: posts.title ?? '',
                                      amount: ((posts.price!) *
                                              (controller.dateTimeRange.value!
                                                  .duration.inDays))
                                          .toString());
                                },
                              )),
                          gap()
                        ],
                      ),
                    ),
                  ),
          )
        ],
      ),
      floatingActionButton: posts.postedBy.toString() ==
              MemoryManagement.getUserId()
          ? const SizedBox.shrink()
          : Obx(() {
              return !controller.showBooking.value
                  ? const SizedBox.shrink()
                  : SizedBox(
                      width: 40.w,
                      child: CustomButton(
                        title: 'Book Now',
                        onPressed: () {
                          showDateRangePicker(
                                  context: context,
                                  firstDate: DateTime.now(),
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: darkBrown,
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 365)))
                              .then((v) => {
                                    {
                                      if (v != null)
                                        {
                                          controller.dateTimeRange.value = v,
                                          controller.showBooking.value = false,
                                          controller.pageController
                                              .animateToPage(1,
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  curve: Curves.easeIn)

                                          // controller.dateController.text =
                                          //     getFormattedDate(v)!,
                                          // controller.date = v,
                                          // FocusScope.of(context).nextFocus()
                                        }
                                    }
                                  });
                        },
                      ),
                    );
            }),
    );
  }
}
