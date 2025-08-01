import 'package:cakewake_delivery/core/constants/setup_constants.dart';
import 'package:cakewake_delivery/core/widgets/custom_button.dart';
import 'package:cakewake_delivery/core/widgets/work_timing_card.dart';
import 'package:cakewake_delivery/features/authentication/controllers/otp_controller.dart';
import 'package:cakewake_delivery/features/userProfile/controllers/work_setupcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WorkTimingScreen extends GetView<WorkSetupController> {

final controller2= Get.find<OtpController>();

   WorkTimingScreen({super.key});

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
              value: 1.0,
              backgroundColor: Colors.grey[200],
              color: Theme.of(context).colorScheme.primary,
              minHeight: 4,
              borderRadius: BorderRadius.circular(8.r),
            ),
            SizedBox(height: 40.h),
            Obx(
              () => Column(
                children: [
                  WorkTimingCard(
                    workTiming: 'Morning Shift',
                    onChanged: controller.selectWorkTiming,
                    selectedWorkTiming: controller.selectedWorkTiming.value,
                  ),
                  SizedBox(height: 20.h),
                  WorkTimingCard(
                    workTiming: 'Evening Shift',
                    onChanged: controller.selectWorkTiming,
                    selectedWorkTiming: controller.selectedWorkTiming.value,
                  ),
                  SizedBox(height: 20.h),
                  WorkTimingCard(
                    workTiming: 'Part Time| 4-6 hours',
                    onChanged: controller.selectWorkTiming,
                    selectedWorkTiming: controller.selectedWorkTiming.value,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Obx(
              () => CustomButton(
                text: 'Continue',
                onPressed: () async {
                  await controller.submitWorkSetup();
                  if (controller.response.success == true) {
                    SetupConstants().isWorkSetup = true;
                    controller2.isWorkSetupCompleted = true;

                    Get.offAllNamed('/welcome', arguments: {
                      'workSetup': true,
                      'profileSetup': SetupConstants().isProfileSetup,
                    'documentSetup': SetupConstants().isDocumentSetup,
                  });
                  }
                },
                isEnabled: controller.selectedWorkTiming.value.isNotEmpty,
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}