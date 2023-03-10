import 'package:griha/app/network/api_endpoints.dart';
import 'package:griha/app/services/app_services.dart';
import 'package:griha/app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:sizer/sizer.dart';

Services services = Get.put(AppServices());

void showCustomSnackBar({required String message, int? milliseconds}) {
  Get.showSnackbar(GetSnackBar(
    message: message,
    duration: Duration(milliseconds: milliseconds ?? 1000),
  ));
}

String formatImageUrl(String imageUrl) {
  var url = '${APIs.ipAddress}/$imageUrl';
  return url;
}

String getAvatar({required String name, Color? color}) {
  var splitName = name.split(' ');
  return 'http://ui-avatars.com/api/?name=${splitName.first.characters}&length=2&format=png&rounded=true&size=256&background=${color ?? '9C91FB'}&color=${color ?? 'FFFFFF'}';
}

String formatToK(int number) {
  if (number >= 1000) {
    return '${(number / 1000).toStringAsFixed(1)}K';
  } else {
    return number.toString();
  }
}

//create a enum for payment mode
enum PaymentMode { cash, khalti }

String generateUniqueFileName(String originalFileName) {
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  String extension = path.extension(originalFileName);
  String uniqueFileName = '$timestamp$extension';

  return uniqueFileName;
}

Widget getProfile(String name, {Color? color, double? radius}) {
  return CircleAvatar(
    backgroundColor: color ?? const Color(0xff9C91FB),
    backgroundImage: NetworkImage(getAvatar(name: name)),
    radius: radius ?? 13.w,
  );
}

PaymentSuccessModel getPaymentSuccessModel(String value) {
  String paymentSuccessString = value;
// Extracting the data between the curly braces
  String dataString = paymentSuccessString
      .substring(paymentSuccessString.indexOf('{') + 1,
          paymentSuccessString.lastIndexOf('}'))
      .trim();

// Creating a map from the data string
  Map<String, Object?> dataMap = {};
  dataString.split(',').forEach((data) {
    List<String> keyValue = data.trim().split(':');
    String key = keyValue[0].trim();
    String value = keyValue[1].trim();

    // Removing quotes from the value if it is a string
    if (value.startsWith("'") && value.endsWith("'")) {
      value = value.substring(1, value.length - 1);
    }

    dataMap[key] = value;
  });

// Creating the PaymentSuccessModel instance from the map
  PaymentSuccessModel paymentSuccessModel =
      PaymentSuccessModel.fromMap(dataMap);
  return paymentSuccessModel;
}

String getImageUrl(String? imageUrl) {
  if (imageUrl == null) return '';
  var url = '${APIs.ipAddress}/$imageUrl';
  print(url);
  return url;
}

String? getFormattedDate(DateTime? date) {
  if (date == null) return null;
  var dateParse = DateFormat('yyyy-MM-dd').format(date);
  return dateParse;
}

String? getFormattedTime(TimeOfDay? time) {
  if (time == null) return null;
  final localizations = MaterialLocalizations.of(Get.context!);
  return localizations.formatTimeOfDay(time);
}

String? getFormattedTimeFromDate(String? date) {
  if (date == null) return null;
  final time = TimeOfDay.fromDateTime(DateTime.parse(date));
  final localizations = MaterialLocalizations.of(Get.context!);
  return localizations.formatTimeOfDay(time);
}
