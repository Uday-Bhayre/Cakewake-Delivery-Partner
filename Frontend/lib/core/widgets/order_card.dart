import 'package:cakewake_delivery/core/widgets/custom_button.dart';
import 'package:cakewake_delivery/features/home/controllers/home_screen_controller.dart';
import 'package:cakewake_delivery/features/home/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  OrderCard({super.key, required this.order});

  final controller = Get.find<HomeScreenController>();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color:
          Theme.of(context).brightness == Brightness.dark
              ? Color(0xFF1A1A1A) // Dark mode background
              : Color(0xFFF9F9FD), // Light mode background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: Color.fromARGB(255, 202, 202, 249), width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  order.customerName,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                Icon(Icons.currency_rupee, color: Colors.green, size: 20.sp),
                Text(
                  order.earning,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(height: 11.h),
            Row(
              children: [
                Container(
                  width: 15.r,
                  height: 15.r,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 1.5.w),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Pickup:',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            SizedBox(
              width: 210.w,
              child: Text(
                order.pickupAddress,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: const Color.fromARGB(255, 186, 40, 29),
                          size: 21.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Drop:',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    SizedBox(
                      width: 210.w,
                      child: Text(
                        order.deliveryAddress,
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
                const Spacer(),
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
                        order.estimatedTime,
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
            SizedBox(height: 13.h),
            order.accepted == true
                ? SizedBox(
                  width: 340.w,
                  child: CustomButton(
                    text: "View details",
                    onPressed: () {
                      Get.toNamed('/orderDetails',
                      arguments: {
                        'order': order,
                      });
                    },
                  ),
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 155.w,
                      height: 52.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.onSecondary,
                          // color: const Color.fromARGB(255, 186, 40, 29),
                          width: 1.5.w,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 155.w,
                      height: 52.w,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (controller.currentOrder.value == null) {
                            order.accepted = true;
                            controller.setCurrentOrder(order);
                            controller.orders.refresh();
                          } else {
                            Get.snackbar(
                              "Order already accepted",
                              "You can only accept one order at a time.",
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.red,
                            );
                          }
                        },
                        child: Text(
                          'Accept',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
