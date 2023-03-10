import 'package:dio/dio.dart';
import 'package:griha/app/models/api_response.dart';
import 'package:griha/app/models/cities.dart';
import 'package:griha/app/routes/app_pages.dart';
import 'package:griha/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Rx<bool> isLoading = false.obs;

  //TODO: Implement LoginController

  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void validateLoginForm() {
    if (emailController.text.isEmpty) {
      showCustomSnackBar(message: 'Email is required', milliseconds: 1000);
    } else if (!emailController.text.isEmail) {
      showCustomSnackBar(message: 'Invalid Email', milliseconds: 1000);
    } else if (passwordController.text.isEmpty) {
      showCustomSnackBar(message: 'Password is required', milliseconds: 1000);
    } else if (passwordController.text.length < 6) {
      showCustomSnackBar(
          message: 'Password must be at least 6 characters',
          milliseconds: 1000);
    } else {
      onLogin();
    }
  }

  void onLogin() async {
    try {
      isLoading.value = true;
      var value = await services.login(
          email: emailController.text, password: passwordController.text);
      if (value is ApiResponse && value.isSucces) {
        Get.offAllNamed(Routes.MAIN);
        showCustomSnackBar(message: value.message, milliseconds: 1000);
      } else if (value is ApiResponse && !value.isSucces) {
        showCustomSnackBar(message: value.message, milliseconds: 1000);
      } else {
        showCustomSnackBar(message: 'Something went wrong', milliseconds: 1000);
      }
    } on DioError catch (dioError) {
      showCustomSnackBar(message: dioError.response?.data, milliseconds: 1000);
    } catch (e) {
      showCustomSnackBar(message: e.toString(), milliseconds: 1000);
    } finally {
      isLoading.value = false;
    }
  }

  void increment() => count.value++;
}
