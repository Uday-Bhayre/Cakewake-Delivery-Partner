import 'package:cakewake_delivery/core/widgets/custom_button.dart';
import 'package:cakewake_delivery/core/widgets/customtextfield.dart';
import 'package:cakewake_delivery/features/userProfile/controllers/document_setup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AadhaarScreen extends GetView<DocumentSetupController> {

  const AadhaarScreen({super.key});

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
        child: Form(
          key: controller.aadharKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                LinearProgressIndicator(
                  value: 0.666,
                  backgroundColor: Colors.grey[200],
                  color: Theme.of(context).colorScheme.primary,
                  minHeight: 4,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                SizedBox(height: 10.h),
                Image.asset('assets/images/profile/aadhaarLogo.png',
                    width: 120.w, 
                    height: 120.h
                    ),
                SizedBox(height: 30.h),
                Text(
                  'Fill Aadhaar Card Details',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  'Aadhaar ID should be linked to your mobile number.',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
            
                SizedBox(height: 40.h),
            
                CustomTextField(
                  controller: controller.aadhaarController,
                  labelText: 'Aadhaar Number',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Aadhaar Number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 40.h),
                CustomButton(
                  text: 'Continue',
                  onPressed: () {
                    if (controller.aadharKey.currentState!.validate()) {
                      Get.toNamed('/pancard');
                    }
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
