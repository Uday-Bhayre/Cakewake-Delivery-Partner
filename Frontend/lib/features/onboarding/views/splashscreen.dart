
import 'package:cakewake_delivery/features/onboarding/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});

  final controller = Get.find<SplashController>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          image: DecorationImage(
            image: AssetImage('assets/images/onboarding/splash.png'),
            repeat: ImageRepeat.repeat,
            fit: BoxFit.none,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.primary.withAlpha(70),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/onboarding/cup2.svg'),
              SizedBox(height: 1.h),
              Text(
                'CakeWake',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.w400,
                  fontSize: 34.sp,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
