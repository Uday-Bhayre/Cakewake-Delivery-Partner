import 'package:cakewake_delivery/core/widgets/custom_button.dart';
import 'package:cakewake_delivery/core/widgets/permanent_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FinalVehicleDetailsScreen extends StatelessWidget {
  const FinalVehicleDetailsScreen({super.key});
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
          " Vehicle Details",
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
            PermanentTextfield(hintText: "Vehicle Type", value: "Bike"),
            SizedBox(height: 30.h),
            PermanentTextfield(hintText: "Vehicle Color", value: "Red"),
            SizedBox(height: 30.h),
            PermanentTextfield(hintText: "Manufacturing year", value: "2020"),
            SizedBox(height: 30.h),
            PermanentTextfield(
              hintText: "Vehicle no",
              value: "MP-09-AB-1234",
            ),
            
          ],
        ),
      ),
    );
  }
}
