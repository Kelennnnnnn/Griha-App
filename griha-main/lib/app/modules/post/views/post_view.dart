import 'dart:typed_data';

import 'package:griha/app/components/custom_textButton.dart';

import 'package:griha/app/components/custom_textfield_form.dart';
import 'package:griha/app/modules/home/controllers/home_controller.dart';
import 'package:griha/app/modules/login/controllers/login_controller.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/post_controller.dart';

class PostView extends GetView<PostController> {
  const PostView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var postController = Get.put(PostController());

    gap({double? height, double? width}) => SizedBox(
          height: height ?? 5.w,
          width: width ?? 5.w,
        );
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 5.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Property Description',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Colors.red,
                ),
              ),
              gap(),
              Row(
                children: [
                  Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              gap(height: 2.w),
              SizedBox(
                width: 100.w,
                child: GetBuilder<HomeController>(
                    id: 'categories',
                    initState: (state) {},
                    builder: (controller) {
                      if (controller.categories == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (postController.selectedCategory.value == 0) {
                        postController.selectedCategory.value =
                            controller.categories?.data?.first.categoryId ?? 0;
                      }

                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.w),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ),
                        child: DropdownButton(
                          underline: const SizedBox(),
                          dropdownColor: Colors.grey.shade100,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          onChanged: (v) {
                            postController.selectedCategory.value = v!;
                            controller.update(['categories']);
                          },
                          elevation: 10,
                          borderRadius: BorderRadius.circular(2.w),
                          value: postController.selectedCategory.value,
                          items: controller.categories?.data
                              ?.map(
                                (e) => DropdownMenuItem(
                                  value: e.categoryId,
                                  child: SizedBox(
                                    width: 75.w,
                                    child: Text(
                                      e.title ?? '',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      );
                    }),
              ),

              SizedBox(
                height: 2.h,
              ),
              Text(
                'General Information',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              CustomTextFieldForm(
                  title: '',
                  hintText: 'Title',
                  textInputAction: TextInputAction.next,
                  controller: controller.titleController),
              gap(),
              CustomTextFieldForm(
                  title: '',
                  hintText: 'Description',
                  textInputAction: TextInputAction.next,
                  isMultiLine: true,
                  controller: controller.descriptionController),
              gap(),
              CustomTextFieldForm(
                  title: '',
                  hintText: 'Price',
                  textInputAction: TextInputAction.next,
                  controller: controller.priceController),
              gap(),
              CustomTextFieldForm(
                  title: '',
                  hintText: 'Number of Room',
                  textInputAction: TextInputAction.next,
                  controller: controller.totalRoomsController),
              gap(),
              CustomTextFieldForm(
                  title: '',
                  hintText: 'Number of Living Room',
                  textInputAction: TextInputAction.next,
                  controller: controller.totalLivingRoomController),
              gap(),
              CustomTextFieldForm(
                  title: '',
                  hintText: 'Number of Kitchen',
                  textInputAction: TextInputAction.next,
                  controller: controller.numberOfKitchenController),
              gap(),
              GetBuilder<PostController>(
                  id: 'features',
                  builder: (controller) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.featuresController.value.length,
                      itemExtent: 25.w,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CustomTextFieldForm(
                          suffixIcon: index == 0
                              ? null
                              : IconButton(
                                  onPressed: () {
                                    controller.removeFeature(index);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red.withOpacity(0.8),
                                  ),
                                ),
                          title: '',
                          hintText: 'Factility ${index + 1}',
                          controller:
                              controller.featuresController.value[index],
                        );
                      },
                    );
                  }),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      controller.addFeature();
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          // color: lightGreen,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          'Add more facility +',
                          style: TextStyle(),
                        )),
                  ),
                ],
              ),
              gap(height: 2.w),

              CustomTextFieldForm(
                title: '',
                hintText: 'Street address',
                textInputAction: TextInputAction.next,
                controller: controller.streetAddressController,
              ),
              gap(height: 5.w),
              Row(
                children: [
                  Text(
                    'City/Region',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              gap(height: 2.w),
              GetBuilder<PostController>(
                  id: 'cities',
                  builder: (controller) {
                    if (controller.cities == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SizedBox(
                      width: 100.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.w),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ),
                        child: DropdownButton(
                          underline: const SizedBox(),
                          dropdownColor: Colors.grey.shade100,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          onChanged: (v) {
                            postController.selectedCity.value = v!;
                            controller.update(['cities']);
                          },
                          elevation: 10,
                          borderRadius: BorderRadius.circular(2.w),
                          value: postController.selectedCity.value,
                          items: controller.cities?.data
                              ?.map(
                                (e) => DropdownMenuItem(
                                  value: e.cityId,
                                  child: SizedBox(
                                    width: 75.w,
                                    child: Text(
                                      e.cityName ?? '',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    );
                  }),
              SizedBox(
                height: 5.w,
              ),
              Text(
                'Upload Image',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5.w,
              ),
              GetBuilder<PostController>(
                  id: 'image',
                  builder: (controller) {
                    return controller.images?.value.isEmpty ?? true
                        ? Container(
                            height: 45.w,
                            width: 85.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: IconButton(
                              onPressed: () {
                                controller.pickImage();
                              },
                              icon: Icon(
                                Icons.add,
                                size: 35.sp,
                                color: Colors.black,
                              ),
                            ),
                          )
                        : SizedBox(
                            width: 85.w,
                            height: 40.w,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    (controller.images?.value.length ?? 0) + 1,
                                itemBuilder: (context, index) {
                                  return index !=
                                          (controller.images?.value.length ?? 0)
                                      ? Stack(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                right: 2.w,
                                              ),
                                              height: 40.w,
                                              width: 60.w,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: MemoryImage(controller
                                                      .imageBytes.value[index]),
                                                ),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            Positioned(
                                              top: 0.w,
                                              right: 1.w,
                                              child: IconButton(
                                                onPressed: () {
                                                  controller.removeImage(index);
                                                },
                                                icon: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.w),
                                                  ),
                                                  child: Icon(
                                                    Icons.remove_circle_outline,
                                                    size: 20.sp,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(
                                          height: 40.w,
                                          width: 30.w,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              controller.pickImage();
                                            },
                                            icon: Icon(
                                              Icons.add,
                                              size: 35.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                        );
                                }),
                          );
                  }),
              // CustomTextField(
              //   readOnly: true,
              //   title: '',
              //   hintText: 'Date',
              //   controller: controller.dateController,
              //   suffixIcon: GestureDetector(
              //     onTap: () async {
              //       showDatePicker(
              //               context: context,
              //               initialDate: DateTime.now(),
              //               firstDate: DateTime.now(),
              //               builder: (BuildContext context, Widget? child) {
              //                 return Theme(
              //                   data: ThemeData.light().copyWith(
              //                     colorScheme: ColorScheme.light(
              //                       primary: darkBrown,
              //                     ),
              //                   ),
              //                   child: child!,
              //                 );
              //               },
              //               lastDate:
              //                   DateTime.now().add(const Duration(days: 365)))
              //           .then((v) => {
              //                 {
              //                   if (v != null)
              //                     {
              //                       controller.dateController.text =
              //                           getFormattedDate(v)!,
              //                       controller.date = v,
              //                       FocusScope.of(context).nextFocus()
              //                     }
              //                 }
              //               });
              //     },
              //     child: Icon(
              //       Icons.calendar_today,
              //       color: darkBrown,
              //     ),
              //   ),
              // ),
              gap(),
              gap(),
              Obx(() => CustomButton(
                    title: 'Post',
                    onPressed: postController.post,
                    isLoading: controller.isLoading.value,
                  )),
            ],
          ),
        ),
      ),
    ));
  }
}
