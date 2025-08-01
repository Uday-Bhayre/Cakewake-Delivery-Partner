import 'package:cakewake_delivery/features/home/controllers/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBottomNavigationBar extends StatelessWidget {
  AppBottomNavigationBar({super.key});

   final controller = Get.find<HomeScreenController>();
  @override
  Widget build(BuildContext context) {
    return  BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_outlined),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_rupee),
            label: 'Earnings',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          Get.find<HomeScreenController>().setCurrentIndex(index);
          switch (index) {
            case 0:
              Get.offAllNamed('/home');
              break;
            case 1:
             // Get.toNamed('/mapScreen');
              break;
            case 2:
            //  Get.toNamed('/orderDetails');
              break;
            case 3:
              Get.toNamed('/profilePage');
              break;
          }
        },
      );
  }
}