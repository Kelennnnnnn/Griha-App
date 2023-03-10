import 'package:griha/app/components/custom_textButton.dart';
import 'package:griha/app/components/custom_textfield.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
        child: Column(
          children: [
            CustomTextField(
              title: '',
              hintText: 'Enter current password',
              controller: controller.oldPasswordController,
              isPassword: true,
            ),
            SizedBox(
              height: 2.h,
            ),
            CustomTextField(
              title: '',
              hintText: 'Enter new password',
              controller: controller.newPasswordController,
              isPassword: true,
            ),
            SizedBox(
              height: 2.h,
            ),
            CustomTextField(
              title: '',
              hintText: 'Confirm new password',
              controller: controller.confirmPasswordController,
              isPassword: true,
            ),
            SizedBox(
              height: 5.h,
            ),
            Obx(
              () => CustomButton(
                isLoading: controller.isLoading.value,
                title: "Change Password",
                onPressed: controller.onChangePassword,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
