import 'package:griha/app/utils/memory_management.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  //TODO: Implement SearchController
  TextEditingController searchController = TextEditingController();
  List<String> recentSearches = [];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getRecentSarches();
  }

  void clearAll() {
    recentSearches.clear();
    MemoryManagement.clearRecentSearches();

    update(['recentSearches']);
  }

  void getRecentSarches() {
    recentSearches = MemoryManagement.getRecentSearches() ?? [];
    update(['recentSearches']);
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
