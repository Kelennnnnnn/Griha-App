import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:griha/app/components/post_card.dart';
import 'package:griha/app/models/categories.dart';
import 'package:griha/app/utils/assets.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../controllers/detail_category_controller.dart';

class DetailCategoryView extends GetView<DetailCategoryController> {
  const DetailCategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Category category = Get.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(category.title!),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: GetBuilder<DetailCategoryController>(
              id: 'posts',
              builder: (controller) {
                if (controller.posts == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (controller.posts!.value.isEmpty) {
                  return NoPostFound(
                    title: 'No properties found for ${category.title}',
                  );
                }
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                    vertical: 5.w,
                  ),
                  child: SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.posts!.value.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: EdgeInsets.only(
                              bottom: 5.w,
                            ),
                            child: PostCardSearch(
                              posts: controller.posts!.value[index],
                            ));
                      },
                    ),
                  ),
                );
              }),
        ));
  }
}

class NoPostFound extends StatelessWidget {
  final String? title;
  const NoPostFound({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 20.h,
              child: Transform.scale(
                  scale: 3.5, child: Lottie.asset(Assets.notFoundLottie))),
          SizedBox(
            height: 5.h,
          ),
          Center(
            child: SizedBox(
              width: 70.w,
              child: Text(
                title ?? 'No posts Found!',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
