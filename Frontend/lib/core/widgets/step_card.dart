import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StepCard extends StatelessWidget {
  final String step;
  final String title;
  final String subtitle;
  final bool isActive;
  final String navigate;
  final Function()? onTap;

  const StepCard({
    required this.step,
    required this.title,
    required this.subtitle,
    required this.isActive,
    required this.navigate,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: Colors.white,
            child:
                isActive
                    ? CircleAvatar(
                      radius: 14.r,
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.check,
                        size: 20.sp,
                        color: Colors.white,
                      ),
                    )
                    : Text(
                      step,
                      style: TextStyle(
                        color: const Color(0xFF7C6AED),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                subtitle,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey[500]),
            onPressed: () {
              if(isActive) {
                return;
              }
              if (onTap != null) {
                onTap!();
              }
              Get.toNamed(navigate);
            },
          ),
        ],
      ),
    );
  }
}
