import 'package:griha/app/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final bool isLoading;
  final Color? color;
  final Color? textColor;

  final Function()? onPressed;
  const CustomButton(
      {super.key,
      required this.title,
      this.onPressed,
      this.isLoading = false,
      this.color,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          gradient: color != null
              ? null
              : LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    primaryColor.shade500,
                    primaryColor.shade800,
                  ],
                ),
          borderRadius: BorderRadius.circular(10.w),
        ),
        width: double.infinity,
        height: 7.h,
        child: isLoading
            ? Center(
                child: SizedBox(
                  child: CircularProgressIndicator(
                    strokeWidth: 0.75.w,
                    color: Colors.white,
                  ),
                ),
              )
            : Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
      ),
    );
  }
}
