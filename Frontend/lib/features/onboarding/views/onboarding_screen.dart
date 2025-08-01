import 'package:cakewake_delivery/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnBoardingScreen extends StatelessWidget {
   OnBoardingScreen({super.key});

  final box=GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/images/onboarding/delivery_boy.svg',
                width: 366.w,
                height: 362.h,
                semanticsLabel: 'Delivery Partner',
              ),
              SizedBox(height: 10.h),
              Text(
                'Deliver Smiles,\nEarn Miles.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 38.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 26.h),
      
              Text(
                'Join CakeWake and start earning with every delivery — fast, simple, and rewarding.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              SizedBox(height: 90.h),
              CustomButton(text: 'Get Started', onPressed: () {
                box.write('onboardingCompleted', true);
                Get.offAllNamed('/authentication');
              }),
            ],
          ),
        ),
      ),
    );
  }
}
