import 'dart:io';

import 'package:cakewake_delivery/core/widgets/custom_button.dart';
import 'package:cakewake_delivery/features/userProfile/controllers/work_setupcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UploadRcScreen extends GetView<WorkSetupController> {
  const UploadRcScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 7),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            onPressed: Get.back,
          ),
        ),
        titleSpacing: 6.w,
        title: Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Row(
            children: [
              const Spacer(),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1.5.w,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.help_outline,
                      size: 17,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      AppLocalizations.of(context)!.help,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 18.w),
              GestureDetector(
                onTap: () => Get.toNamed('/language'),
                child: SvgPicture.asset(
                  'assets/images/profile/language2.svg',
                  width: 28.w,
                  height: 28.h,
                ),
              ),
              SizedBox(width: 13.w),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            LinearProgressIndicator(
              value: 0.750,
              backgroundColor: Colors.grey[200],
              color: Theme.of(context).colorScheme.primary,
              minHeight: 4,
              borderRadius: BorderRadius.circular(8.r),
            ),
            SizedBox(height: 30.h),
            Text(
              'Upload RC',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Text(
              'Upload a clear photo of your vehicle’s\nregistration certificate',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
            SizedBox(height: 40.h),
            Obx(
              () => Center(
                child: Container(
                  width: 334.w,
                  height: 181.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondary,
                    borderRadius: BorderRadius.circular(8.r),
                    image:
                        controller.rcImage.value != null
                            ? DecorationImage(
                              image: FileImage(
                                File(controller.rcImage.value!.path),
                              ),
                              fit: BoxFit.cover,
                            )
                            : null,
                  ),
                  child:
                      controller.rcImage.value == null
                          ? Center(
                            child: Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.white,
                            ),
                          )
                          : null,
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: GestureDetector(
                onTap: () => controller.pickImg(context, controller.rcImage),
                child: Container(
                  width: 70.w,
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onSurface,
                      width: 2.w,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 60.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 24.sp,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Obx(()=>
            CustomButton(text: 'Continue',
             onPressed: (){
               controller.insuranceImg.value=null;
               Get.toNamed('/uploadInsurance');
             },
             isEnabled: controller.rcImage.value != null,))
          ],
        ),
      ),
    );
  }
}
