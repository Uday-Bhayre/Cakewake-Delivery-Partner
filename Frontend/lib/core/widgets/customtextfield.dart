import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
   final TextInputType? keyboardType;
    const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.keyboardType,
  });

  Widget build(BuildContext context) {
    return SizedBox(
      width: 358.w,
      // height: 58.h,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 16.sp,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(13.r)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13.r),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1.5.w,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13.r),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 1.5.w,
            ),
          ),
        ),
        keyboardType: keyboardType ?? TextInputType.text,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}

