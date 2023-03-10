import 'package:griha/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

const fontName = 'Poppins';

final ThemeData lightTheme = ThemeData(
  drawerTheme: const DrawerThemeData(
      // backgroundColor: backgroundColor.withOpacity(0.90),
      ),
  brightness: Brightness.light,
  listTileTheme: const ListTileThemeData(),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: darkBrown,
  ),
  primarySwatch: primaryColor,
  shadowColor: shadowColor,
  appBarTheme: AppBarTheme(
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      fontFamily: fontName,
      fontSize: 17.sp,
      color: Colors.white,
    ),
    backgroundColor: darkBrown,
    shadowColor: shadowColor.withOpacity(0.5),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: const TextStyle(fontFamily: fontName, color: secondaryColor),
    disabledBorder: (OutlineInputBorder(
      borderSide: const BorderSide(color: secondaryColor),
      borderRadius: BorderRadius.circular(
        2.5.w,
      ),
    )),
    focusedBorder: (OutlineInputBorder(
      borderSide: const BorderSide(color: secondaryColor),
      borderRadius: BorderRadius.circular(
        2.5.w,
      ),
    )),
    border: OutlineInputBorder(
      // borderSide: BorderSide(color: secondaryColor),
      borderRadius: BorderRadius.circular(
        2.5.w,
      ),
    ),
  ),
  primaryColor: backgroundColor,
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  fontFamily: fontName,
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontFamily: fontName,
      fontSize: 20.sp,
      color: const Color(0xff000000),
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: const TextStyle(color: Colors.black, fontFamily: fontName),
    displayLarge: const TextStyle(color: Colors.black, fontFamily: fontName),
    displayMedium: const TextStyle(color: Colors.black, fontFamily: fontName),
    displaySmall: const TextStyle(color: Colors.black, fontFamily: fontName),
    headlineMedium: const TextStyle(color: Colors.black, fontFamily: fontName),
    headlineSmall: const TextStyle(color: Colors.black, fontFamily: fontName),
    titleLarge: const TextStyle(color: Colors.black, fontFamily: fontName),
    titleMedium: const TextStyle(color: Colors.black, fontFamily: fontName),
    titleSmall: const TextStyle(color: Colors.black, fontFamily: fontName),
    bodySmall: const TextStyle(color: Colors.black),
    labelSmall: const TextStyle(color: Colors.black),
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(primary: primaryColor, secondary: Colors.white),
);
