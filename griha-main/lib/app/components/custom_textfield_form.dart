import 'package:griha/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextFieldForm extends StatefulWidget {
  final String title;
  final String hintText;
  final bool isPassword;
  final Widget? suffix;
  final bool autofocus;
  final bool isEnabled;
  final Widget? suffixIcon;
  final void Function()? ontap;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final bool readOnly;
  final bool isRequired;
  final bool isMultiLine;

  const CustomTextFieldForm(
      {super.key,
      required this.title,
      required this.hintText,
      this.isPassword = false,
      this.suffix,
      required this.controller,
      this.onChanged,
      this.keyboardType,
      this.suffixIcon,
      this.textInputAction,
      this.readOnly = false,
      this.isEnabled = true,
      this.ontap,
      this.autofocus = false,
      this.isRequired = true,
      this.isMultiLine = false});

  @override
  State<CustomTextFieldForm> createState() => _CustomTextFieldFormState();
}

class _CustomTextFieldFormState extends State<CustomTextFieldForm> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 1.w,
        ),
        TextFormField(
          autofocus: widget.autofocus,
          enabled: widget.isEnabled,
          onTap: widget.ontap,
          readOnly: widget.readOnly,
          textInputAction: widget.textInputAction,
          keyboardType: widget.keyboardType,
          inputFormatters: [],
          minLines: widget.isMultiLine ? 5 : 1,
          maxLines: widget.isMultiLine ? 5 : 1,
          onChanged: widget.onChanged,
          controller: widget.controller,
          obscureText: widget.isPassword ? !isVisible : false,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            alignLabelWithHint: true,
            label: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.hintText),
                if (widget.isRequired)
                  Padding(
                    padding: EdgeInsets.only(left: 1.w, top: 2.5.w),
                    child: Text(
                      '*',
                      style: TextStyle(color: Colors.red, fontSize: 23.sp),
                    ),
                  )
              ],
            ),
            labelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14.sp,
              color: textFieldHintColor,
              fontWeight: FontWeight.w500,
            ),
            suffix: widget.suffix,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
            // hintText: widget.hintText,
            hintStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12.sp,
              color: textFieldHintColor,
            ),
            suffixIcon: widget.suffixIcon ??
                (widget.isPassword
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: Icon(
                          isVisible ? Icons.visibility : Icons.visibility_off,
                          size: 13.sp,
                          color: Colors.black,
                        ),
                      )
                    : null),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1.w),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3.w),
              borderSide: BorderSide(
                color: Colors.grey.shade500,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3.w),
              borderSide: BorderSide(
                color: Colors.grey.shade500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
