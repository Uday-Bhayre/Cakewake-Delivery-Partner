import 'package:cakewake_delivery/core/widgets/app_bar.dart';
import 'package:cakewake_delivery/core/widgets/bottom_navigation_bar.dart';
import 'package:cakewake_delivery/core/widgets/custom_button.dart';
import 'package:cakewake_delivery/features/home/controllers/home_screen_controller.dart';
import 'package:cakewake_delivery/features/home/controllers/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderDetailsScreen extends StatelessWidget {
  final controller = Get.find<MapController>();
  final controller2 = Get.find<HomeScreenController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: CustomAppBar(
          isonline: controller2.isOnline.value,
          onChanged: controller2.toggleOnlineStatus,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 6.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Live Order
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Live Order",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          "Order ID: ${controller.currentOrder.value!.orderId}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Checkbox(
                      value: controller.isDelivered.value,
                      onChanged: (_) {
                        controller.isDelivered.value =
                            !controller.isDelivered.value;
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                    Text(
                      "Delivered",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pickup",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                        SizedBox(
                          width: 210.w,
                          child: Text(
                            controller.currentOrder.value!.pickupAddress,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Checkbox(
                      value: controller.isPickedUp.value,
                      onChanged: (_) {
                        if (controller.isPickedUp.value) {
                          Get.snackbar(
                            "Error",
                            "Cannot change pickup status after delivery",
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red,
                          );
                          return;
                        }
                        controller.isPickedUp.value =
                            !controller.isPickedUp.value;
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                    Text(
                      "PickedUp",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                // Map Placeholder
                Center(
                  child: Container(
                    height: 280,
                    width: 360.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            'https://maps.googleapis.com/maps/api/staticmap'
                            '?center=28.4595,77.0266'
                            '&zoom=15'
                            '&size=600x300'
                            '&markers=color:red%7Clabel:P%7C28.4595,77.0266'
                            '&markers=color:red%7Clabel:D%7C28.4675,77.0326'
                            '&path=color:blue|weight:5|28.4595,77.0266|28.4675,77.0326'
                            '&key=AIzaSyD19MebWM9G6n4J6yr01dF8OKEho_hvl2Y',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 10,
                          bottom: 96,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 4),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                SizedBox(width: 4),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Drop Location",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.onSecondary,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 180.w,
                                      child: Text(
                                        controller
                                            .currentOrder
                                            .value!
                                            .deliveryAddress,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          bottom: 16,
                          child: SizedBox(
                            width: 340.w,
                            child: CustomButton(
                              onPressed: () async {
                                await controller.initializingMap();
                                Get.toNamed('/mapScreen');
                              },
                              text: "Get Directions",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 22.h),
                // Customer Details
                Text(
                  "Customer Details",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 19.sp,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 7.h),
                Row(
                  children: [
                    Column(
                      children: [
                        Icon(Icons.person),
                        SizedBox(height: 9.h),
                        Icon(Icons.location_on_outlined),
                        SizedBox(height: 7.h),
                      ],
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 210.w,
                              child: Text(
                                controller.currentOrder.value!.customerName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        SizedBox(
                          width: 210.w,
                          child: Text(
                            controller.currentOrder.value!.deliveryAddress,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      width: 70.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 2.h),
                          Text(
                            "ETA",
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            controller.currentOrder.value!.estimatedTime
                                .toString(),
                            style: TextStyle(
                              fontSize: 23.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'mins',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                          SizedBox(height: 7.h),
                        ],
                      ),
                    ),
                  ],
                ),
                // Items
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Text(
                      "Items",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24.sp,
                        color: Theme.of(context).colorScheme.onSurface,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Total: ₹",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                        color: Theme.of(context).colorScheme.onSurface,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      "999",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                        color: Theme.of(context).colorScheme.onSurface,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8,
                  ),
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          "https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=80&q=80",
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text("Velvet Gold Crunch"),
                      subtitle: Text("500g\nQty: 1"),
                      trailing: Text(
                        "₹999",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Total: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "₹999",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
        bottomNavigationBar: AppBottomNavigationBar(),
      ),
    );
  }
}
