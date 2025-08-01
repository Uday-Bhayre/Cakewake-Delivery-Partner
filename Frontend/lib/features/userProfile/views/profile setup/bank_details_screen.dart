import 'package:cakewake_delivery/core/constants/setup_constants.dart';
import 'package:cakewake_delivery/core/widgets/custom_button.dart';
import 'package:cakewake_delivery/core/widgets/custom_dropdown.dart';
import 'package:cakewake_delivery/core/widgets/customtextfield.dart';
import 'package:cakewake_delivery/features/authentication/controllers/otp_controller.dart';
import 'package:cakewake_delivery/features/userProfile/controllers/profile_controller.dart';
import 'package:cakewake_delivery/features/userProfile/repository/profile_setup_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BankDetailsScreen extends GetView<ProfileController> {
  
  BankDetailsScreen({super.key});
  final controller2= Get.find<OtpController>();
  final setupconst= SetupConstants();
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
              value: 0.666,
              backgroundColor: Colors.grey[200],
              color: Theme.of(context).colorScheme.primary,
              minHeight: 4,
              borderRadius: BorderRadius.circular(8.r),
            ),
            SizedBox(height: 20.h),
            Text(
              "Enter your bank details",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Text(
              "Your earnings will be transferred to this bank account every week",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
            SizedBox(height: 40.h),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: controller.bankFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: controller.bankNameController,
                        labelText: "Account holder name",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter account holder name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30.h),
                      CustomTextField(
                        controller: controller.accountNo,
                        labelText: "Account no",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter account no";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30.h),
                      CustomTextField(
                        controller: controller.reAccountNo,
                        labelText: "Re-enter Account no",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please re-enter account no";
                          } else if (value != controller.accountNo.text) {
                            return "Account numbers do not match";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30.h),
                      CustomDropDown(
                        items: ProfileSetupServices.banks,
                        hintText: "Bank name",
                        onChanged: (value) {
                          controller.selectedBank.value = value ?? '';
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select a bank";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomButton(
              text: 'Continue',
              onPressed: () async{
                if (controller.bankFormKey.currentState!.validate()) {
                 await controller.submitProfile();
                  if (controller.response.success == true) {
                     setupconst.isProfileSetup=true;
                     controller2.isProfileSetupCompleted = true;
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
          ],
        ),
      ),
    );
  }
}
