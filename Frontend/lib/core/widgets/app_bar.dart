import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

   final bool isonline;
   final Function() onChanged;

   
   const CustomAppBar({super.key, required this.isonline, required this.onChanged});
  @override
  Size get preferredSize => Size.fromHeight(119.h);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(119.h),
        child: Container(
          color: Theme.of(context).colorScheme.primary,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Text(
                        'CakeWake',
                        style: TextStyle(
                          fontFamily: 'Pacifico',
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 90.w,
                        height: 40.h,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            side: BorderSide(color: Colors.white, width: 1.5.w),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.help_outline,
                                size: 17,
                                color: Colors.white,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                AppLocalizations.of(context)!.help,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 18.w),
                      GestureDetector(
                        onTap: () => Get.toNamed('/language'),
                        child: SvgPicture.asset(
                          'assets/images/profile/language.svg',
                          width: 28.w,
                          height: 28.h,
                        ),
                      ),
                     
                    ],
                  ),
                  SizedBox(height: 19.h),
                  Row(
                    children: [
                      Text(
                        'Hi, Anshu',
                        style: TextStyle(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      SizedBox(
                        width: 41.w,
                        height: 10.h,
                        child: Transform.scale(
                          scale: 0.7,
                          child: Switch(
                            activeTrackColor: Colors.green,
                            activeColor: Colors.white,
                            inactiveTrackColor: Colors.grey.shade400,
                            inactiveThumbColor: Colors.white,
                            value: isonline,
                            onChanged: (value) {
                              onChanged();
                            },
                          ),
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                         Row(
                            children: [
                              CircleAvatar(
                                radius: 4.r,
                                backgroundColor: isonline ? const Color.fromARGB(255, 95, 218, 100) : Colors.grey,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                'Active Shift',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: isonline ? const Color.fromARGB(255, 95, 218, 100) : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Text(
                              '8am-5pm',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}