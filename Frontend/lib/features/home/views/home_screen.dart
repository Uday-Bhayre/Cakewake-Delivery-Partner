import 'package:cakewake_delivery/core/widgets/app_bar.dart';
import 'package:cakewake_delivery/core/widgets/bottom_navigation_bar.dart';
import 'package:cakewake_delivery/core/widgets/order_card.dart';
import 'package:cakewake_delivery/features/home/controllers/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends GetView<HomeScreenController> {

  const HomeScreen({super.key});
  final String address =
      "Kamal Residency, Gujjar rd, Sector 64, Gurgaon Haryana";
  @override
  Widget build(BuildContext context) {
    return Obx(() =>Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar:  CustomAppBar(
            isonline: controller.isOnline.value,
            onChanged: controller.toggleOnlineStatus,
          ),
      body:
        controller.orders.isEmpty?
           Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 80.h),
              Center(
                child: Image.asset(
                  'assets/images/home/delivery_rider.png',
                  width: 250.w,
                  height: 240.h,
                ),
              ),
              Text(
                "You are online",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Text(
                "waiting for new orders",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ],
          )
          :
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
           child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'New Delivery requests',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: ListView.separated(
                    itemCount: controller.orders.length,
                    separatorBuilder: (context, index) => SizedBox(height: 10.h),
                    controller: controller.scrollController,
                    itemBuilder: (context, index) {
                      final order = controller.orders[index];
                      return OrderCard(
                       order: order,
                      );
                    },
                  ),
                ),
              ],
            ),
         ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(height: 1, thickness: 1, color: Colors.grey.shade300),
           AppBottomNavigationBar(),
        ],
      ),
    )
    );
  }
}
