import 'package:griha/app/components/custom_textfield.dart';
import 'package:griha/app/components/post_card.dart';
import 'package:griha/app/modules/home/controllers/home_controller.dart';
import 'package:griha/app/modules/main/controllers/main_controller.dart';
import 'package:griha/app/modules/search/controllers/search_controller.dart';
import 'package:griha/app/utils/assets.dart';
import 'package:griha/app/utils/memory_management.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

var searchController = Get.put(SearchController());

class SearchBox extends StatelessWidget {
  final bool ishome;
  final bool isSearch;
  const SearchBox({super.key, this.ishome = false, this.isSearch = false});

  @override
  Widget build(BuildContext context) {
    var mainController = Get.find<MainController>();
    return GestureDetector(
      onTap: () {
        if (ishome) {
          mainController.persistentTabController.jumpToTab(1);
        }
      },
      child: SizedBox(
        child: CustomTextField(
          autofocus: isSearch ? true : false,
          title: '',
          isEnabled: ishome ? false : true,
          hintText: 'Search',
          controller: searchController.searchController,
          suffix: const Icon(
            Icons.search,
            color: Colors.black,
          ),
          onChanged: (value) {
            if (searchController.searchController.text.isNotEmpty) {
              showSearch(
                context: context,
                delegate: SearchViewDelegate(),
                query: searchController.searchController.text,
              );
              searchController.searchController.clear();
            }
          },
        ),
      ),
    );
  }
}

var homeController = Get.put(HomeController());

class SearchViewDelegate extends SearchDelegate {
  var searchResults = homeController.posts?.value;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isNotEmpty) {
            query = '';
          } else {
            close(context, null);
          }
        },
        icon: const Icon(
          Icons.close,
        ),
        splashRadius: 12.sp,
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var suggestions = searchResults?.where((elements) {
      var element = elements;
      var query1 = query.toLowerCase();
      return element.title?.toLowerCase().contains(query1) ?? false;
    }).toList();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 5.w,
      ),
      child: suggestions?.isEmpty ?? true
          ? Center(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.scale(
                      scale: 2.5,
                      child: Lottie.asset(
                        Assets.notFoundLottie,
                      ),
                    ),
                    SizedBox(
                      height: 10.w,
                    ),
                    SizedBox(
                      width: 70.w,
                      child: Text(
                        'No Results Found, try something else',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : GestureDetector(
              onTap: () {},
              child: ListView.builder(
                itemCount: suggestions?.length,
                itemBuilder: ((context, index) {
                  return PostCardSearch(posts: suggestions![index]);
                }),
              ),
            ),
    );
  }
}
