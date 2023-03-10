import 'package:griha/app/components/custom_textButton.dart';
import 'package:griha/app/components/custom_textfield.dart';
import 'package:griha/app/routes/app_pages.dart';
import 'package:griha/app/utils/assets.dart';
import 'package:griha/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 7.5.w, horizontal: 3.5.w),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Text(
                      'Welcome Back!',
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins'),
                    ),
                    SizedBox(height: 5.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 85.w,
                          child: Text(
                            'Log In to your Home Rental account to explore your dream place to live across the whole world!',
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400,
                                color: textFieldHintColor,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 7.w),
                    CustomTextField(
                      controller: controller.emailController,
                      title: 'Email',
                      hintText: 'Enter your email',
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 3.h),
                    CustomTextField(
                      controller: controller.passwordController,
                      title: 'Password',
                      hintText: 'Insert your password here',
                      textInputAction: TextInputAction.done,
                      isPassword: true,
                    ),
                    SizedBox(height: 3.h),
                    Obx(
                      () => CustomButton(
                        isLoading: controller.isLoading.value,
                        title: 'Log In',
                        onPressed: controller.validateLoginForm,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t Have An Account?',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.REGISTER);
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Positioned(
            //   top: -19.w,
            //   left: -10.w,
            //   child: CircleAvatar(
            //     radius: 33.w,
            //     backgroundColor: Color(0xff2B475C).withOpacity(0.9),
            //   ),
            // ),
            // Positioned(
            //   top: -19.w,
            //   right: -10.w,
            //   child: CircleAvatar(
            //     radius: 33.w,
            //     backgroundColor: Color(0xff5E8A75).withOpacity(0.9),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
