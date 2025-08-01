import 'package:cakewake_delivery/core/widgets/custom_button.dart';
import 'package:cakewake_delivery/core/widgets/permanent_textfield.dart';
import 'package:cakewake_delivery/features/profile_details/controllers/your_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BankInfoScreen extends GetView<YourProfileController> {
  const BankInfoScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),

        title: Text(
          " Bank Details",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6.0),
        child: Column(
          children: [  
            SizedBox(height: 106.h),
            PermanentTextfield(
              hintText: "Account number", 
              value: controller.maskAccountNumber("1234567890"),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 20),
                  SizedBox(width: 8.w),
                  Text(
                    "Verified",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 8.w),
                ],
              ),),
            SizedBox(height: 30.h),
            PermanentTextfield(hintText: "Bank name", value: "Bank of India"),
            SizedBox(height: 30.h),
            PermanentTextfield(hintText: "IFSC code", value: "BKID0001234"),
            SizedBox(height: 30.h),
            PermanentTextfield(
              hintText: "Account holder name",
              value: "Marcus Franci",
            ),    
          ],
        ),
      ),
    );
  }
}
