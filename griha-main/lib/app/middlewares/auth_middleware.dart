import 'package:griha/app/routes/app_pages.dart';
import 'package:griha/app/utils/memory_management.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    try {
      if (!MemoryManagement.getLoginStatus()) {
        return const RouteSettings(name: Routes.WELCOME);
      }
    } catch (e) {
      return const RouteSettings(name: Routes.WELCOME);
    }
    return null;
  }
}
