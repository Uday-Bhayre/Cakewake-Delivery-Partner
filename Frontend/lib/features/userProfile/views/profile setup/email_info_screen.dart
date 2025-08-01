import 'package:cakewake_delivery/core/widgets/custom_button.dart';
import 'package:cakewake_delivery/core/widgets/customtextfield.dart';
import 'package:cakewake_delivery/features/userProfile/controllers/profile_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserInfoScreen extends GetView<ProfileController> {
  const UserInfoScreen({super.key});

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
              value: 0.333,
              backgroundColor: Colors.grey[200],
              color: Theme.of(context).colorScheme.primary,
              minHeight: 4,
              borderRadius: BorderRadius.circular(8.r),
            ),
            SizedBox(height: 40.h),
            Text(
              'Enter your name and email address',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 46.h),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller: controller.nameController,
                        labelText: 'Name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 36.h),
                      CustomTextField(
                        controller: controller.emailController,
                        labelText: 'Email',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!GetUtils.isEmail(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "Select your gender",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                              value: 'Male',
                              groupValue: controller.selectedGender.value,
                              onChanged: (value) {
                                controller.selectedGender.value = value!;
                              },
                            ),
                            Text(
                              "Male",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(width: 60.w),
                             Radio(
                              value: 'Female',
                              groupValue: controller.selectedGender.value,
                              onChanged: (value) {
                                controller.selectedGender.value = value!;
                              },
                            ),
                            Text(
                              "Female",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomButton(
              text: 'Continue',
              onPressed: () {
                if(controller.selectedGender.value.isEmpty) {
                  Get.snackbar(
                    'Error',
                    'Please select your gender');
                  return;
                }
                if (controller.formKey.currentState!.validate()) {
                   Get.toNamed('/bankDetails');
                }
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
