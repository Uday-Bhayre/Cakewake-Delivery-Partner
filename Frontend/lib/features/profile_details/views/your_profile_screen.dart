import 'package:cakewake_delivery/core/widgets/custom_button.dart';
import 'package:cakewake_delivery/core/widgets/permanent_textfield.dart';
import 'package:cakewake_delivery/features/home/controllers/home_screen_controller.dart';
import 'package:cakewake_delivery/features/profile_details/controllers/your_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:io';

class YourProfileScreen extends GetView<YourProfileController> {
 
         YourProfileScreen({super.key});
    
    final controller2= Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),

        title: Text(
          " Your Profile",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6.0),
        child: Column(
          children: [
            SizedBox(height: 56.h),
           Obx(()=> Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
                    backgroundImage: FileImage(
                      File(controller.profileImage .value!.path),
                    ),
                  
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () {
                        controller.pickProfileImg();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          Icons.edit,
                          color: Theme.of(context).colorScheme.onSurface,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
           ),
            SizedBox(height: 66.h),
            PermanentTextfield(hintText: "Name", value: controller2.profileData!.name),
            SizedBox(height: 30.h),
            PermanentTextfield(hintText: "Email", value: controller2.profileData!.email),
            SizedBox(height: 30.h),
            PermanentTextfield(hintText: "Contact", value: controller2.profileData!.contact),
            SizedBox(height: 30.h),
            PermanentTextfield(
              hintText: "Work Address",
              value: "${controller2.profileData!.workArea}, ${controller2.profileData!.workCity}",
            ),
            Spacer(),
            CustomButton(text: "Save Changes", onPressed: () {
              controller.updateProfile();
            },
            isEnabled: controller.profileImage.value!=controller2.profileData!.profileImage,
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
