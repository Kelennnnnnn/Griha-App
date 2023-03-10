import 'package:griha/app/components/custom_textButton.dart';
import 'package:griha/app/routes/app_pages.dart';
import 'package:griha/app/utils/assets.dart';
import 'package:griha/app/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 90.w,
            child: Lottie.asset(Assets.houseLottie),
          ),
          Text(
            'New Place, New Home',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 5.w),
          SizedBox(
            width: 85.w,
            child: Text(
              'Are you ready to uproot and start over in a new area? Home Rental will help you on your journey!',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: textFieldHintColor,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 5.w),
          CustomButton(
            title: 'Log In',
            onPressed: () {
              Get.toNamed(Routes.LOGIN);
            },
          ),
          SizedBox(height: 3.w),
          CustomButton(
            title: 'Sign Up',
            color: secondaryButtonColor,
            textColor: Colors.black.withOpacity(0.7),
            onPressed: () {
              Get.toNamed(Routes.REGISTER);
            },
          ),
          SizedBox(height: 15.w),
        ],
      ),
    ));
  }
}
