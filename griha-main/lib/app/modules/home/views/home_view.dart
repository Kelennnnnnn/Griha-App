import 'package:griha/app/components/house_card.dart';
import 'package:griha/app/components/post_card.dart';
import 'package:griha/app/components/search_box.dart';
import 'package:griha/app/models/item_model.dart';
import 'package:griha/app/modules/main/controllers/main_controller.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:griha/app/routes/app_pages.dart';
import 'package:griha/app/utils/colors.dart';
import 'package:sizer/sizer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return Scaffold(
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: () async {
          await controller.onRefresh();
        },
        child: SizedBox(
          height: 100.h,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 2.w,
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 80.w,
                        height: 30.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            SearchBox(),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.NOTIFICATIONS);
                        },
                        child: Icon(
                          Icons.notifications,
                          color: primaryColor,
                          size: 20.sp,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Categories',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14.sp,
                              color: Colors.red,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5.w,
                        ),
                        SizedBox(
                          height: 25.w,
                          child: GetBuilder<HomeController>(
                              id: 'categories',
                              builder: (controller) {
                                if (controller.categories == null) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        controller.categories?.data?.length ??
                                            0,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(Routes.DETAIL_CATEGORY,
                                              arguments: controller
                                                  .categories!.data![index]);
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 25.w,
                                              height: 15.w,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    controller.categories!
                                                        .data![index].imageUrl!,
                                                  ),
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2.w,
                                            ),
                                            Text(
                                              controller.categories!
                                                  .data![index].title!,
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              }),
                        ),
                        Text(
                          'Properties for You',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        GetBuilder<HomeController>(
                            id: 'posts',
                            builder: (controller) {
                              if (controller.posts == null) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (controller.posts!.value.isEmpty) {
                                return const Center(
                                  child: Text('No posts Found'),
                                );
                              }
                              return SizedBox(
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 1.w,
                                    crossAxisSpacing: 3.w,
                                    childAspectRatio: 0.75,
                                  ),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.posts!.value.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: EdgeInsets.only(
                                          bottom: 5.w,
                                        ),
                                        child: PostCard(
                                          posts: controller.posts!.value[index],
                                        ));
                                  },
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
