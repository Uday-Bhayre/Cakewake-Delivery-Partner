import 'package:cakewake_delivery/core/widgets/custom_button.dart';
import 'package:cakewake_delivery/core/widgets/step_card.dart';
import 'package:cakewake_delivery/features/authentication/controllers/otp_controller.dart';
import 'package:cakewake_delivery/features/userProfile/controllers/work_setupcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeScreen extends GetView<WorkSetupController> {
  final bool workSetup;
  final bool profileSetup;
  final bool documentSetup;
 
   final controller2= Get.find<OtpController>();

  WelcomeScreen({super.key}) //initializer list
    : workSetup = (Get.arguments?['workSetup'] ?? false),
      profileSetup = (Get.arguments?['profileSetup'] ?? false),
      documentSetup = (Get.arguments?['documentSetup'] ?? false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 290.h,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 60.h),
                    Row(
                      children: [
                        Text(
                          'CakeWake',
                          style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.onPrimary,
                              width: 1.w,
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.help_outline,
                                size: 17,
                                color: Colors.white,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                AppLocalizations.of(context)!.help,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 18.w),
                        GestureDetector(
                          onTap: () => Get.toNamed('/language'),
                          child: SvgPicture.asset(
                            'assets/images/profile/language.svg',
                            width: 28.w,
                            height: 28.h,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.welcome,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.welcome2,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              AppLocalizations.of(context)!.subtitle,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFD8D6F5),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          'assets/images/profile/boy.svg',
                          width: 90.w,
                          height: 166.h,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.heading,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  StepCard(
                    step: "1",
                    title: AppLocalizations.of(context)!.step1,
                    subtitle: AppLocalizations.of(context)!.step1Subtitle,
                    isActive: workSetup || controller2.isWorkSetupCompleted,
                    navigate: '/location',
                  ),
                  SizedBox(height: 12.h),
                  StepCard(
                    step: "2",
                    title: AppLocalizations.of(context)!.step2,
                    subtitle: AppLocalizations.of(context)!.step2Subtitle,
                    isActive: profileSetup || controller2.isProfileSetupCompleted,
                    navigate: '/profile',
                  ),
                  SizedBox(height: 12.h),
                  StepCard(
                    step: "3",
                    title: AppLocalizations.of(context)!.step3,
                    subtitle: AppLocalizations.of(context)!.step3Subtitle,
                    isActive: documentSetup || controller2.isDocumentSetupCompleted,
                    navigate: '/documentPic',
                  ),
                  SizedBox(height: 135.h),
                  CustomButton(
                    text: AppLocalizations.of(context)!.continueBtn,
                    onPressed: () {
                      Get.offAllNamed('/home');
                    },
                    isEnabled: controller2.isWorkSetupCompleted  && controller2.isProfileSetupCompleted && controller2.isDocumentSetupCompleted,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
