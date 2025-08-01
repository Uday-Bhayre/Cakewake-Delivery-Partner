import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSearchfield extends StatelessWidget{

 final String hintText;
 final Function(String) onChanged;
  const CustomSearchfield({super.key, required this.hintText, required this.onChanged});

  @override
  Widget build (BuildContext context){
    return SizedBox(
      width: 358.w,
      height: 48.0.h,
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSecondary,
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1.5.w,
            ),
          ),  
        ),
      ),
    );
  }
}