import 'package:cakewake_delivery/core/widgets/custom_button.dart';
import 'package:cakewake_delivery/features/authentication/controllers/otp_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends GetView<OtpController> {

  final String phoneNumber;
   const OtpScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).colorScheme.onSurface,
            size: 20.sp,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('OTP Verification',
        style:TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
          color: Theme.of(context).colorScheme.onSurface,
        )),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.w), 
        child: SingleChildScrollView(
          child: Column( 
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Text(
                  'We have sent a verification code to',
                  
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '1234567890',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 44.h),
              Form(
                key: controller.formKey,
                child: Pinput(
                  length: 6,
                  defaultPinTheme: PinTheme(
                    width: 43.w,
                    height: 43.h,
                    textStyle: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onSecondary,
                        width: 1.w,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                    width: 43.w,
                    height: 43.h,
                    textStyle: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                   validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Please enter a valid OTP';
                    }
                    return null;
                  },
                  errorTextStyle: TextStyle( 
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 182, 43, 33),
                    fontFamily: 'Inter',
                  ),
                  keyboardType: TextInputType.number,
                  showCursor: false,
                  onChanged: (value) {
                    controller.onOtpChanged(value); 
                  },
                ),
              ),
              SizedBox(height: 20.h),
              Obx(() => controller.timer.value > 0
                  ? Text(
                      'Resend OTP in ${controller.timer.value} sec',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    )
                  : GestureDetector(
                      onTap: () async {
                        await controller.resendOtp(phoneNumber); // call resend
                      },
                      child: Text(
                        'Resend OTP',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                          color: Theme.of(context).colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )),
              SizedBox(height: 450.h),
              CustomButton(text: 'Verify OTP', onPressed: 
              () async{
                if(controller.formKey.currentState!.validate()){
                   await controller.verifyOtpCode();
                }
              }
              )
            ],
          ),
        ),
      ),
    );
  }
}