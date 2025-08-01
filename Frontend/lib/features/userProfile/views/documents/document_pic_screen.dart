
import 'dart:io';

import 'package:cakewake_delivery/core/constants/setup_constants.dart';
import 'package:cakewake_delivery/core/widgets/custom_button.dart';
import 'package:cakewake_delivery/features/userProfile/controllers/cameraController.dart';
import 'package:cakewake_delivery/features/userProfile/controllers/document_setup_controller.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DocumentPicScreen extends StatelessWidget {

      DocumentPicScreen({super.key});
   
   final controller1 = Get.find<DocumentSetupController>();
   final controller2 = Get.find<UserCameraController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
          ),
          onPressed: () {
            if(controller1.capturedImg.value==null)
            {
              SetupConstants().isDocumentSetup=false;
            }
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Stay still & Capture now',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 30.h),
            Obx(()=>
            Center(
              child: controller1.capturedImg.value == null?
              ClipOval(
                child: SizedBox(
                  width: 280.w,
                  height: 280.h,
                  child: controller2.isCameraInitialized.value ?
                  CameraPreview(controller2.cameraController):
                  Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                      strokeWidth: 2.w,
                    ),
                  ),
                ),
              ):
              Stack(
                alignment: Alignment.center,
                children: [
                ClipOval(
                  child: Image.file(
                    File(controller1.capturedImg.value!.path),
                    width: 280.w,
                    height: 280.h,  
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton.filled(
                    onPressed: (){
                      controller1.capturedImg.value = null;
                      controller2.cameraController.resumePreview();
                    },
                     icon: Icon(
                      Icons.close,
                      size: 24.sp,
                      color: Theme.of(context).colorScheme.onSurface,
                     ))
                ,)

              ],)
            )
            ),
            const Spacer(),
            Center(
              child: GestureDetector(
                onTap: () async {
                  controller1.capturedImg.value = await controller2.captureImg();
                },
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
              Get.toNamed('aadhaar');
             },
             isEnabled: controller1.capturedImg.value != null,)),
             SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}