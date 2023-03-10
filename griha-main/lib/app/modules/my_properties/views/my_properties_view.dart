import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:griha/app/components/post_card.dart';
import 'package:griha/app/modules/detail_category/views/detail_category_view.dart';
import 'package:sizer/sizer.dart';

import '../controllers/my_properties_controller.dart';

class MyPropertiesView extends GetView<MyPropertiesController> {
  const MyPropertiesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Properties'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: GetBuilder<MyPropertiesController>(
              id: 'posts',
              builder: (controller) {
                if (controller.posts == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (controller.posts!.value.isEmpty) {
                  return const NoPostFound();
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
                              isMyPosts: true,
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
