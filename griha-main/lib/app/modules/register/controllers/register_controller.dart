import 'package:dio/dio.dart';
import 'package:griha/app/models/api_response.dart';
import 'package:griha/app/modules/login/controllers/login_controller.dart';
import 'package:griha/app/routes/app_pages.dart';
import 'package:griha/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  LoginController loginController = Get.put(LoginController());

  Rx<bool> isLoading = false.obs;

  //TODO: Implement RegisterController

  final count = 0.obs;
  @override
  void onInit() {
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

  void validateRegisterForm() {
    if (nameController.text.isEmpty) {
      showCustomSnackBar(message: 'Full Name is required');
    } else if (phoneController.text.isEmpty) {
      showCustomSnackBar(message: 'Phone is required');
    } else if (phoneController.text.length < 10) {
      showCustomSnackBar(message: 'Phone number must be 10 digits');
    } else if (emailController.text.isEmpty) {
      showCustomSnackBar(message: 'Email is required');
    } else if (!emailController.text.isEmail) {
      showCustomSnackBar(message: 'Invalid Email');
    } else if (passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      showCustomSnackBar(message: 'Password is required');
    } else if (passwordController.text.length < 6) {
      showCustomSnackBar(
          message: 'Password must be at least 6 characters',
          milliseconds: 1000);
    } else if (passwordController.text != confirmPasswordController.text) {
      showCustomSnackBar(message: 'Password does not match');
    } else {
      onRegister();
    }
  }

  void onRegister() async {
    try {
      isLoading.value = true;
      var res = await services.register(
        fullName: nameController.text,
        email: emailController.text,
        phoneNumber: phoneController.text,
        password: passwordController.text,
      );

      if (res is ApiResponse && res.isSucces) {
        Get.offAllNamed(Routes.LOGIN);
        showCustomSnackBar(message: res.message);
      } else if (res is ApiResponse && !res.isSucces) {
        showCustomSnackBar(message: res.message);
      } else {
        showCustomSnackBar(message: 'Something went wrong');
      }
    } on DioError catch (e) {
      showCustomSnackBar(message: e.response?.data ?? 'Something went wrong');
    } catch (e) {
      showCustomSnackBar(message: 'Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }

  void increment() => count.value++;
}
