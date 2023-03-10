import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:griha/app/models/api_response.dart';
import 'package:griha/app/models/cities.dart';
import 'package:griha/app/modules/home/controllers/home_controller.dart';
import 'package:griha/app/modules/main/controllers/main_controller.dart';
import 'package:griha/app/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PostController extends GetxController {
  Rx<int> selectedCategory = 0.obs;
  MainController mainController = Get.find();
  Rx<List<XFile>>? images = Rx<List<XFile>>([]);
  Rx<List<Uint8List>> imageBytes = Rx<List<Uint8List>>([]);
  final ImagePicker imagePicker = ImagePicker();

  Cities? cities;
  Rx<int> selectedCity = 0.obs;

//TEXT EDITING CONTROLLERS
  Rx<List<TextEditingController>> featuresController =
      Rx<List<TextEditingController>>([TextEditingController()]);
  Rx<bool> isLoading = false.obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController totalRoomsController = TextEditingController();
  TextEditingController totalLivingRoomController = TextEditingController();
  TextEditingController numberOfKitchenController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  HomeController homeController = Get.find();

  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    await getCities();
  }

  Future<void> getCities() async {
    try {
      var res = await services.getCities();

      if (res is Cities) {
        cities = res;
        if (selectedCity.value == 0) {
          selectedCity.value = cities?.data?[0].cityId ?? 0;
        }

        update(['cities']);
      } else {
        cities = Cities();
      }
    } catch (e) {
      print(e);
    } finally {
      update(['cities']);
    }
  }

  void removeFeature(int index) {
    featuresController.value.removeAt(index);
    update(['features']);
  }

  void addFeature() {
    featuresController.value.add(TextEditingController());
    update(['features']);
  }

  void removeImage(int index) {
    if (images != null) {
      images!.value.removeAt(index);
      imageBytes.value.removeAt(index);
    }

    update(['image']);
  }

  void pickImage() async {
    try {
      await imagePicker.pickImage(source: ImageSource.gallery).then((value) {
        if (value != null) {
          images!.value.add(value);
          imageBytes.value.add(File(value.path).readAsBytesSync());
          // imageBytes.value = File(value.path).readAsBytesSync();
          update(['image']);
        }
      });
    } catch (e) {}
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> post() async {
    if (selectedCategory.value == 0) {
      showCustomSnackBar(message: 'Please select category', milliseconds: 1000);
    } else if (titleController.text.isEmpty) {
      showCustomSnackBar(message: 'Please enter title', milliseconds: 1000);
    } else if (descriptionController.text.isEmpty) {
      showCustomSnackBar(
          message: 'Please enter description', milliseconds: 1000);
    } else if (priceController.text.isEmpty) {
      showCustomSnackBar(message: 'Please enter price', milliseconds: 1000);
    } else if (totalRoomsController.text.isEmpty) {
      showCustomSnackBar(
          message: 'Please enter total rooms', milliseconds: 1000);
    } else if (totalLivingRoomController.text.isEmpty) {
      showCustomSnackBar(
          message: 'Please enter total living rooms', milliseconds: 1000);
    } else if (numberOfKitchenController.text.isEmpty) {
      showCustomSnackBar(
          message: 'Please enter number of kitchen', milliseconds: 1000);
    } else if (featuresController.value.isEmpty) {
      showCustomSnackBar(message: 'Please enter features', milliseconds: 1000);
    } else if (images!.value.isEmpty) {
      showCustomSnackBar(message: 'Please select image', milliseconds: 1000);
    } else {
      await makePost();
    }
  }

  void resetFields() {
    selectedCategory.value = 0;
    images!.value = [];
    featuresController.value = [TextEditingController()];
    titleController.text = '';
    descriptionController.text = '';
    priceController.text = '';
    totalRoomsController.text = '';
    totalLivingRoomController.text = '';
    numberOfKitchenController.text = '';
  }

  Future<void> makePost() async {
    try {
      isLoading.value = true;
      var res = await services.addPost(
        categoryId: selectedCategory.value,
        cityId: selectedCity.value,
        title: titleController.text,
        description: descriptionController.text,
        price: priceController.text,
        totalRooms: totalRoomsController.text,
        totalBedrooms: totalLivingRoomController.text,
        numberOfKitchen: numberOfKitchenController.text,
        facilities:
            jsonEncode(featuresController.value.map((e) => e.text).toList()),
        streetAddress: streetAddressController.text,
        images: images!.value,
      );

      if (res is ApiResponse && res.isSucces) {
        resetFields();

        mainController.persistentTabController.jumpToTab(0);
        await homeController.getPosts();
        showCustomSnackBar(message: res.message, milliseconds: 1000);
      } else if (res is ApiResponse && !res.isSucces) {
        showCustomSnackBar(message: res.message, milliseconds: 1000);
      } else {
        showCustomSnackBar(message: 'Something went wrong', milliseconds: 1000);
      }
    } on DioError catch (e) {
      print(e.response?.data ?? "no data");

      showCustomSnackBar(message: 'Something went wrong', milliseconds: 1000);
    } finally {
      isLoading.value = false;
    }
  }

  void increment() => count.value++;
}
