import 'dart:io';

import 'package:griha/app/network/api_endpoints.dart';
import 'package:griha/app/network/api_handler.dart';
import 'package:griha/app/utils/memory_management.dart';
import 'package:griha/app/utils/themes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:sizer/sizer.dart';

import 'app/routes/app_pages.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await MemoryManagement.init();
  await ApiHandler.initDio();
  runApp(
    Sizer(
      builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) =>
          KhaltiScope(
        publicKey: APIs.khaltiKey,
        builder: (context, navigatorKey) => GetMaterialApp(
          navigatorKey: navigatorKey,
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('ne', 'NP'),
          ],
          localizationsDelegates: const [
            KhaltiLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          title: "Application",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          defaultTransition: Transition.cupertino,
          theme: lightTheme,
        ),
      ),
    ),
  );
}
