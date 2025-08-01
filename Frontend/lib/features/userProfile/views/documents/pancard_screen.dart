import 'package:cakewake_delivery/core/constants/setup_constants.dart';
import 'package:cakewake_delivery/core/widgets/custom_button.dart';
import 'package:cakewake_delivery/core/widgets/customtextfield.dart';
import 'package:cakewake_delivery/features/authentication/controllers/otp_controller.dart';
import 'package:cakewake_delivery/features/userProfile/controllers/document_setup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PancardScreen extends GetView<DocumentSetupController> {
  PancardScreen({super.key});

  final setupconst = SetupConstants();
  final controller2 = Get.find<OtpController>();
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
          key: controller.panKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                LinearProgressIndicator(
                  value: 1.0,
                  backgroundColor: Colors.grey[200],
                  color: Theme.of(context).colorScheme.primary,
                  minHeight: 4,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                SizedBox(height: 30.h),
                Text(
                  'Fill PAN Card Details',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  'Your PAN will be verified for secure and accurate processing.',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),

                SizedBox(height: 70.h),

                CustomTextField(
                  controller: controller.panController,
                  labelText: 'PAN number',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter PAN number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40.h),
                Container(
                  width: 358.w,
                  height: 76.h,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(13.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    child: Text(
                      'Keep your PAN card handy for\naccurate entry.',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                CustomButton(
                  text: 'Continue',
                  onPressed: () async {
                    if (controller.panKey.currentState!.validate()) {
                      await controller.saveDocument();
                      if (controller.response.success == true) {
                        setupconst.isDocumentSetup = true;
                        controller2.isDocumentSetupCompleted = true;
                        Get.offAllNamed(
                          '/welcome',
                          arguments: {
                            'workSetup': setupconst.isWorkSetup,
                            'profileSetup': setupconst.isProfileSetup,
                            'documentSetup': setupconst.isDocumentSetup,
                          },
                        );
                      }
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
