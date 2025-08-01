import 'package:cakewake_delivery/core/widgets/custom_button.dart';
import 'package:cakewake_delivery/core/widgets/custom_searchField.dart';
import 'package:cakewake_delivery/features/userProfile/controllers/work_setupcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WorkCityScreen extends GetView<WorkSetupController> {

  const WorkCityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
       appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 7),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            onPressed: Get.back,
          ),
        ),
        titleSpacing: 6.w,
        title: Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Row(
            children: [
              const Spacer(),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1.5.w,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.help_outline,
                      size: 17,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      AppLocalizations.of(context)!.help,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 18.w),
              GestureDetector(
                onTap: () => Get.toNamed('/language'),
                child: SvgPicture.asset(
                  'assets/images/profile/language2.svg',
                  width: 28.w,
                  height: 28.h,
                ),
              ),
              SizedBox(width: 13.w),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            LinearProgressIndicator(
              value: 0.250,
              backgroundColor: Colors.grey[200],
              color: Theme.of(context).colorScheme.primary,
              minHeight: 4,
              borderRadius: BorderRadius.circular(8.r),
            ),
            SizedBox(height: 20.h),
            Text(
              'Select Work City',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Text(
              'Please select the city where you want to work',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
            SizedBox(height: 40.h),
            CustomSearchfield(
              hintText: 'Search your city',
              onChanged: controller.filterCitiesBySearch,
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Obx(() {
                if (controller.filterCities.isEmpty) {
                  return Center(
                    child: Text(
                      'No cities found',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  itemCount: controller.filterCities.length,
                  separatorBuilder: (context, index) => Divider(
                    color: Theme.of(context).colorScheme.onSecondary,
                    height: 1.h,
                  ),
                  itemBuilder: (context, index) {
                    final String city = controller.filterCities[index]['city_ascii']!;
                   
                    return Obx(() { 
                       final bool isSelected = controller.selectedCity.value == city;
                      return RadioListTile<String>(
                        title: Text(city,
                          style: TextStyle(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        value: city,
                        activeColor: Theme.of(context).colorScheme.primary,
                        groupValue: controller.selectedCity.value,
                      onChanged: (value) {
                        controller.selectCity(value!);
                      },
                      controlAffinity: ListTileControlAffinity.trailing,
                    );
                  });
                  },
                );
              }),
            ),
            CustomButton(text: 'Continue', onPressed: (){
               controller.loadAreas();
               controller.selectedArea.value = '';
              Get.toNamed('/workarea');
            },
            isEnabled: controller.cityName.value.isNotEmpty,),
            SizedBox(height: 20.h),
          ],
        ),
      )
    );
  }
}