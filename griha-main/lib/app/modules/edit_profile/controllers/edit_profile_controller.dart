import 'package:dio/dio.dart';
import 'package:griha/app/models/api_response.dart';
import 'package:griha/app/modules/login/controllers/login_controller.dart';
import 'package:griha/app/modules/profile/controllers/profile_controller.dart';
import 'package:griha/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  Rx<bool> isLoading = false.obs;
  var profileController = Get.find<ProfileController>();
  var loginController = Get.put(LoginController());

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    var user = profileController.user?.value;
    if (user != null) {
      nameController.text = user.fullName ?? '';
      emailController.text = user.email ?? '';
      phoneNumberController.text = user.phoneNumber ?? '';

      update(['cities']);

      // weightController.text = user?.weight.toString() ?? '';
    }
  }

  Future<void> updateUser() async {
    try {
      isLoading.value = true;
      var res = await services.updateUserDetails(
        name: nameController.text,
        phoneNumber: phoneNumberController.text,
      );

      if (res is ApiResponse && res.isSucces) {
        await profileController.getUserData();
        Get.back();
        showCustomSnackBar(message: res.message, milliseconds: 1000);
      } else if (res is ApiResponse && !res.isSucces) {
        showCustomSnackBar(message: res.message, milliseconds: 1000);
      } else {
        showCustomSnackBar(message: 'Something went wrong', milliseconds: 1000);
      }
    } on DioError catch (e) {
      showCustomSnackBar(
          message: e.response?.data['message'] ?? 'Something went wrong',
          milliseconds: 1000);
    } catch (e) {
      showCustomSnackBar(message: 'Something went wrong', milliseconds: 1000);
    } finally {
      isLoading.value = false;
    }
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
