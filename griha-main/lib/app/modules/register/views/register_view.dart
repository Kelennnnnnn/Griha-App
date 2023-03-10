import 'package:griha/app/components/custom_textButton.dart';
import 'package:griha/app/components/custom_textfield.dart';
import 'package:griha/app/modules/login/controllers/login_controller.dart';
import 'package:griha/app/routes/app_pages.dart';
import 'package:griha/app/utils/assets.dart';
import 'package:griha/app/utils/colors.dart';
import 'package:griha/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 7.5.w, horizontal: 3.5.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Let\'s explore together!',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins'),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 85.w,
                      child: Text(
                        'Create your Home Rental account to explore your dream place to live!',
                        style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                            color: textFieldHintColor,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                CustomTextField(
                  controller: controller.nameController,
                  title: 'Full Name',
                  hintText: '',
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 3.h),
                CustomTextField(
                  controller: controller.emailController,
                  title: 'Email',
                  hintText: '',
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 3.h),
                CustomTextField(
                  controller: controller.phoneController,
                  title: 'Contact',
                  hintText: '',
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 3.h),
                CustomTextField(
                  controller: controller.passwordController,
                  title: 'Password',
                  hintText: '',
                  textInputAction: TextInputAction.next,
                  isPassword: true,
                ),
                SizedBox(height: 3.h),
                CustomTextField(
                  controller: controller.confirmPasswordController,
                  title: 'Confirm Password',
                  hintText: '',
                  textInputAction: TextInputAction.done,
                  isPassword: true,
                ),
                SizedBox(height: 3.h),
                Obx(
                  () => CustomButton(
                    isLoading: controller.isLoading.value,
                    title: 'Sign Up',
                    onPressed: () {
                      controller.validateRegisterForm();
                    },
                  ),
                ),
                SizedBox(height: 3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: textFieldHintColor,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.LOGIN);
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          color: Colors.red,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
