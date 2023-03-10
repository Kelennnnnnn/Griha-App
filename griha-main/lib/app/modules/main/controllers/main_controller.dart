// ignore_for_file: deprecated_member_use

import 'package:griha/app/modules/booking/views/bookings_view.dart';
import 'package:griha/app/modules/home/views/home_view.dart';
import 'package:griha/app/modules/post/views/post_view.dart';
import 'package:griha/app/modules/profile/controllers/profile_controller.dart';
import 'package:griha/app/modules/profile/views/profile_view.dart';
import 'package:griha/app/modules/search/views/search_view.dart';
import 'package:griha/app/utils/assets.dart';
import 'package:griha/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sizer/sizer.dart';

class MainController extends GetxController {
  final count = 0.obs;

  Rx<bool> autofocus = false.obs;
  ProfileController profileController = Get.put(ProfileController());

  PersistentTabController persistentTabController =
      PersistentTabController(initialIndex: 0);

  TextStyle navButton = TextStyle(
      fontFamily: 'Poppins',
      foreground: Paint()..color = textFieldHintColor,
      fontSize: 12.sp);

  final screens = [
    const HomeView(),
    const BookingsView(),
    const PostView(),
    const ProfileView(),
  ];

  List<PersistentBottomNavBarItem> navBarsItems() {
    double iconHeight = 17.sp;
    Color activeColor = primaryColor;
    Color inactiveColor = textFieldHintColor;
    // double inactiveHeight = isMobile() ? 20.sp : 15.sp;

    return [
      tabItem(
        'Home',
        icon: Icon(
          Icons.home,
          color: activeColor,
        ),
        inactiveIcon: Icon(
          Icons.home,
          color: inactiveColor,
        ),
      ),
      tabItem(
        'Bookings',
        icon: Icon(
          Icons.bookmarks,
          color: activeColor,
        ),
        inactiveIcon: Icon(
          Icons.bookmarks,
          color: inactiveColor,
        ),
      ),
      tabItem(
        'Post',
        icon: Icon(
          Icons.add_circle_outline,
          color: activeColor,
        ),
        inactiveIcon: Icon(
          Icons.add_circle_outline,
          color: inactiveColor,
        ),
      ),
      tabItem('Account',
          icon: Icon(
            Icons.person,
            color: activeColor,
          ),
          inactiveIcon: Icon(
            Icons.person,
            color: inactiveColor,
          )),
    ];
  }

  PersistentBottomNavBarItem tabItem(title,
      {required Widget icon, screen, required Widget inactiveIcon}) {
    return PersistentBottomNavBarItem(
      title: title,
      textStyle: navButton,
      inactiveIcon: inactiveIcon,
      icon: icon,
      activeColorPrimary: darkBrown,
    );
  }

  @override
  void onInit() {
    super.onInit();
    Get.put(ProfileController());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
