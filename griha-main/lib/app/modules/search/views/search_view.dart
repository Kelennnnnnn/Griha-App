import 'package:griha/app/components/search_box.dart';
import 'package:griha/app/models/posts.dart';

import 'package:griha/app/routes/app_pages.dart';

import 'package:griha/app/utils/constants.dart';
import 'package:griha/app/utils/memory_management.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SearchController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 5.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SearchBox(
              //   isSearch: true,
              // ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Searches',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.clearAll();
                      },
                      child: Text(
                        'Clear all',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.w,
                  ),
                  child: GetBuilder<SearchController>(
                      id: 'recentSearches',
                      builder: (controller) {
                        if (controller.recentSearches.isEmpty) {
                          return SizedBox(
                            height: 20.h,
                            child: const Center(
                              child: Text('No recent searches'),
                            ),
                          );
                        }
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return RecentSearch(
                              title: controller.recentSearches[index],
                            );
                          },
                          itemCount: controller.recentSearches.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        );
                      })),
              SizedBox(
                height: 2.h,
              ),
              Text('Trending Workouts',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  )),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecentSearch extends StatelessWidget {
  final String title;
  const RecentSearch({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // showSearch(
        //     context: context, delegate: SearchViewDelegate(), query: title);
      },
      child: SizedBox(
        height: 5.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 11.sp,
              ),
            ),
            IconButton(
              onPressed: () {
                MemoryManagement.removeRecentSearch(search: title);
                // searchController.getRecentSarches();
              },
              icon: Icon(
                Icons.close,
                size: 12.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}
