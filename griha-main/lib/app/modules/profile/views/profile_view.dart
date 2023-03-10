import 'package:griha/app/components/custom_textButton.dart';
import 'package:griha/app/components/custom_textfield.dart';
import 'package:griha/app/components/search_box.dart';
import 'package:griha/app/modules/booking/controllers/bookings_controller.dart';
import 'package:griha/app/modules/main/controllers/main_controller.dart';
import 'package:griha/app/routes/app_pages.dart';
import 'package:griha/app/utils/assets.dart';
import 'package:griha/app/utils/colors.dart';

import 'package:griha/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    var mainController = Get.find<MainController>();
    var bookingsController = Get.put(BookingsController());
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ProfileController>(
            id: 'profile',
            builder: (controller) {
              if (controller.user == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              var data = controller.user?.value;

              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                    vertical: 5.w,
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Hero(
                          tag: 'profilePic',
                          child: CircleAvatar(
                            backgroundColor: const Color(0xff9C91FB),
                            backgroundImage: NetworkImage(
                                getAvatar(name: data?.fullName ?? 'User')),
                            radius: 13.w,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        data?.fullName ?? 'User',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        data?.email ?? 'User',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: textFieldHintColor,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      DetailRow(
                        title: 'Edit profile',
                        icon: const Icon(Icons.person),
                        onTap: () {
                          Get.toNamed(Routes.EDIT_PROFILE);
                        },
                      ),
                      DetailRow(
                        title: 'My Properties',
                        icon: const Icon(Icons.apartment),
                        onTap: () {
                          Get.toNamed(Routes.MY_PROPERTIES);
                        },
                      ),
                      DetailRow(
                        title: 'My Bookings',
                        icon: const Icon(Icons.book),
                        onTap: () {
                          mainController.persistentTabController.jumpToTab(1);
                          bookingsController.initialIndex.value = 1;
                        },
                      ),
                      DetailRow(
                        title: 'Booking Requests',
                        icon: Icon(Icons.bookmarks_sharp),
                        onTap: () {
                          mainController.persistentTabController.jumpToTab(1);
                        },
                      ),
                      DetailRow(
                        title: 'Change Password',
                        icon: const Icon(Icons.key),
                        onTap: () {
                          Get.toNamed(Routes.CHANGE_PASSWORD);
                        },
                      ),
                      DetailRow(
                        title: 'Logout',
                        icon: const Icon(Icons.logout),
                        onTap: () {
                          controller.onLogout();
                        },
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String title;
  final Widget icon;
  final void Function()? onTap;
  const DetailRow(
      {super.key, required this.title, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 17.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 2.w,
            ),
            Container(
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
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ]),
              child: icon,
            ),
            SizedBox(
              width: 5.w,
            ),
            SizedBox(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Spacer(),
            SvgPicture.asset(Assets.chevronRight),
            SizedBox(
              width: 5.w,
            ),
          ],
        ),
      ),
    );
  }
}
