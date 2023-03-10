import 'package:griha/app/components/custom_textButton.dart';
import 'package:griha/app/utils/assets.dart';
import 'package:griha/app/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sizer/sizer.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,

        navBarHeight: 18.w,
        controller: controller.persistentTabController,

        screens: controller.screens,
        items: controller.navBarsItems(),
        confineInSafeArea: true,

        // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.

        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: const NavBarDecoration(),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),

        navBarStyle:
            NavBarStyle.simple, // Choose the nav bar style with this property.
      ),
      endDrawer: Drawer(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 2.h),
                SizedBox(height: 15.w),
                CustomButton(
                    title: 'Log Out',
                    onPressed: () {
                      controller.profileController.onLogout();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
