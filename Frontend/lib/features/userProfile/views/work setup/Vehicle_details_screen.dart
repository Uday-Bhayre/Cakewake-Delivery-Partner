
import 'package:cakewake_delivery/core/widgets/custom_button.dart';
import 'package:cakewake_delivery/core/widgets/custom_dropdown.dart';
import 'package:cakewake_delivery/core/widgets/customtextfield.dart';
import 'package:cakewake_delivery/features/userProfile/controllers/work_setupcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VehicleDetailsScreen extends GetView<WorkSetupController> {
  VehicleDetailsScreen({super.key});

  final List<String> years = List.generate(
    20,
    (i) => (DateTime.now().year - i).toString(),
  );
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
          key: controller.vehicleFormKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      LinearProgressIndicator(
                        value: 0.625,
                        backgroundColor: Colors.grey[200],
                        color: Theme.of(context).colorScheme.primary,
                        minHeight: 4,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      SizedBox(height: 30.h),
                      Text(
                        'Vehicle Details',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        'Let us know about your delivery vehicle to ensure as smooth ride',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),

                      SizedBox(height: 40.h),

                      CustomTextField(
                        controller: controller.vehicleColorController,
                        labelText: 'Vehicle Color',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter vehicle color';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 40.h),
                      CustomDropDown(
                        items: years,
                        hintText: 'Manufacturing Year',
                        onChanged: (value) {
                          controller.manufacturingYear.value = value ?? '';
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a manufacturing year';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 40.h),
                      CustomTextField(
                        controller: controller.vehicleNumberController,
                        labelText: 'Vehicle Number',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter vehicle number';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                text: 'Continue',
                onPressed: () {
                  if (controller.vehicleFormKey.currentState!.validate()) {
                    Get.toNamed('/rcScreen');
                    controller.rcImage.value = null;
                  }
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
