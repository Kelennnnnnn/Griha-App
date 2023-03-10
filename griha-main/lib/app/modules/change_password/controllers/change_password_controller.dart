import 'package:dio/dio.dart';
import 'package:griha/app/components/search_box.dart';
import 'package:griha/app/models/api_response.dart';
import 'package:griha/app/modules/home/controllers/home_controller.dart';
import 'package:griha/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  //TODO: Implement ChangePasswordController
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  HomeController homeController = Get.put(HomeController());
  Rx<bool> isLoading = false.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void onChangePassword() {
    if (oldPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      showCustomSnackBar(
          message: 'Please enter all fields!', milliseconds: 1000);
      return;
    }
    if (newPasswordController.text != confirmPasswordController.text) {
      showCustomSnackBar(
          message: 'Passwords do not match!', milliseconds: 1000);
      return;
    }
    if (newPasswordController.text.length < 6) {
      showCustomSnackBar(
          message: 'Password must be at least 6 characters long!',
          milliseconds: 1000);
      return;
    }
    changePassword();
  }

  void changePassword() async {
    try {
      isLoading.value = true;
      var res = await services.changePassword(
        oldPassword: oldPasswordController.text,
        newPassword: newPasswordController.text,
        email: homeController.profileController.user!.value.email!,
      );

      if (res is ApiResponse && res.isSucces) {
        Get.back();
        showCustomSnackBar(message: res.message, milliseconds: 1000);
      } else if (res is ApiResponse && !res.isSucces) {
        showCustomSnackBar(message: res.message, milliseconds: 1000);
      } else {
        showCustomSnackBar(message: 'Something went wrong', milliseconds: 1000);
      }
    } on DioError catch (e) {
      print(e);
      showCustomSnackBar(
          message: e.response?.data ?? 'Something went wrong!',
          milliseconds: 1000);
    } catch (e) {
      showCustomSnackBar(message: e.toString(), milliseconds: 1000);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
