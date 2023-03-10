import 'package:cached_network_image/cached_network_image.dart';
import 'package:griha/app/models/item_model.dart';
import 'package:griha/app/models/posts.dart';
import 'package:griha/app/modules/my_properties/controllers/my_properties_controller.dart';
import 'package:griha/app/routes/app_pages.dart';
import 'package:griha/app/utils/assets.dart';
import 'package:griha/app/utils/colors.dart';
import 'package:griha/app/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PostCard extends StatelessWidget {
  final Posts posts;
  const PostCard({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DETAILED_POST, arguments: posts);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              width: 100.w,
              height: 35.w,
              child: CachedNetworkImage(
                imageUrl: getImageUrl(posts.pictureUrls?.first),
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Padding(
                padding: EdgeInsets.all(1.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 35.w,
                          child: Text(
                            posts.title ?? '',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.bed),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text('${posts.totalBedroom} Bed room')
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Rs.${posts.price} /day',
                          style: TextStyle(
                            color: primaryColor.shade900,
                            fontSize: 12.sp,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostCardSearch extends StatelessWidget {
  final Posts posts;
  final bool isMyPosts;
  const PostCardSearch(
      {super.key, required this.posts, this.isMyPosts = false});

  @override
  Widget build(BuildContext context) {
    var propertiesController = Get.put(MyPropertiesController());
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DETAILED_POST, arguments: posts);
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: ((context) {
            return Container(
              height: 40.w,
              width: 80.w,
              child: Center(
                child: Container(
                  height: 50.w,
                  width: 80.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Do you want to delete it?',
                            style: TextStyle(
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () async {
                              print(posts.postId);
                              await propertiesController.deletePost(
                                  postId: posts.postId!.toString());
                              Get.close(1);
                            },
                            child: Text(
                              'Yes',
                              style: TextStyle(fontSize: 15.sp),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          TextButton(
                            onPressed: () {
                              Get.close(1);
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(fontSize: 15.sp),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 3.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 40.w,
              height: 35.w,
              child: CachedNetworkImage(
                imageUrl: getImageUrl(posts.pictureUrls?.first),
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 2.w,
                  horizontal: 1.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          posts.title ?? '',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.bed),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text('${posts.totalBedroom} Bed room')
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      children: [
                        Text(
                          'Rs.${posts.price} /day',
                          style: TextStyle(
                            color: primaryColor.shade900,
                            fontSize: 12.sp,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
