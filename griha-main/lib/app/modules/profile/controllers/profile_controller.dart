import 'package:griha/app/components/search_box.dart';
import 'package:griha/app/models/api_response.dart';
import 'package:griha/app/models/user.dart';
import 'package:griha/app/routes/app_pages.dart';
import 'package:griha/app/utils/constants.dart';
import 'package:griha/app/utils/memory_management.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  Rx<User>? user;

  final count = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    print('hi');
    await getUserData();
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

  Future<void> getUserData() async {
    try {
      var data = await services.getUserDetails();
      if (data is ApiResponse) {
      } else if (data is User) {
        user = data.obs;
        mapUserData();

        update(['profile']);
      }
    } catch (e) {}
  }

  void mapUserData() {
    if (user != null) {
      nameController.text = user?.value.fullName ?? '';
      emailController.text = user?.value.email ?? '';

      // birthDateController.text =
      //     getFormattedDate(user?.value.birthDate ?? DateTime.now())!;
      // weightController.text = user!.value.data!.weight.toString();
    }
  }

  void onLogout() async {
    await MemoryManagement.logOut();
    Get.offAllNamed(Routes.MAIN);
  }
}
