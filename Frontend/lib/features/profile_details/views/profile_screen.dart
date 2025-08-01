import 'package:cakewake_delivery/core/widgets/bottom_navigation_bar.dart';
import 'package:cakewake_delivery/core/widgets/profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Profile",
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        )),
         
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
          SizedBox(height: 16),
            Container(
              width: 360.w,
               decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
    
              color: Theme.of(context).brightness == Brightness.light ? const Color(0xFFEFEFFB) : const Color(0xFF2C2C2C),
         
            ),
            padding: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage('assets/profile.jpg'), // Replace with your asset
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text(
                        'Marcus Franci',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '+916799234466',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
           Expanded(
            child: ListView.separated(
              itemCount: 7,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              separatorBuilder: (context, index) => SizedBox
                (height: 10.0),
              itemBuilder: (context, index) {
                final tiles=[
                  ProfileTile(
                    icon: Icons.person_outline,
                    title: 'Your profile',
                    onTap: () {
                      Get.toNamed('/yourProfile');
                    },
                  ),
                  ProfileTile(
                    icon: Icons.directions_car_outlined,
                    title: 'Vehicle information',
                    onTap: () {
                      Get.toNamed('/vehicleInformation');
                    },
                  ),
                  ProfileTile(
                    icon: Icons.account_balance_outlined,
                    title: 'Bank details',
                    onTap: () {
                      Get.toNamed('/bankInfo');
                    },
                  ),
                  ProfileTile(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    onTap: () {},
                  ),
                  ProfileTile(
                    icon: Icons.phone_outlined,
                    title: 'Support',
                    onTap: () {},
                  ),
                  ProfileTile(
                    icon: Icons.info_outline,
                    title: 'About us',
                    onTap: () {},
                  ),
                  ProfileTile(
                    icon: Icons.logout,
                    title: 'Log out',
                    onTap: () {},
                  ),
                ];
                return tiles[index];
              },
            ),
          ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }
}
