import 'package:cakewake_delivery/core/widgets/custom_button.dart';
import 'package:cakewake_delivery/features/userProfile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_storage/get_storage.dart';
class LanguageSelectionScreen extends GetView<ProfileController>{


   LanguageSelectionScreen({super.key});

  final List<Map<String, String>> languages =[
    {'code':'en', 'name':'English','native': 'English'},
    {'code':'hi', 'name': 'Hindi', 'native': 'हिन्दी'},
  ];

  final box=GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          onPressed: Get.back,
           icon: const Icon(Icons.arrow_back_ios_new,size: 20)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(AppLocalizations.of(context)!.selectLanguage,
             style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              
              color: Theme.of(context).colorScheme.onSurface,
             ),),
            SizedBox(height: 6.h),
            Text(AppLocalizations.of(context)!.selectOneBelow,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            ),
            SizedBox(
              height: 120.h,
            ),
            Expanded(
              child: Obx(()=>GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 10.w,
                childAspectRatio: 2,
                children: languages.map((value){
                  final isSelected=controller.selectedCode.value==value['code'];
                  return GestureDetector(
                    onTap: () {
                     
                    },
                    child: Container(
                      
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: isSelected? Theme.of(context).colorScheme.primary: Theme.of(context).colorScheme.onSecondary,
                        width: 1.w
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 6.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Text(value['native']!,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface
                          ),
                          ),
                          Text(value['name']!,
                          style: TextStyle(
                            fontSize: 16.sp,
          
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.onSecondary
                          ),
                          ),
                        ]
                         ),
                         Radio<String>(
                          value: value['code']!,
                          groupValue: controller.selectedCode.value,
                          onChanged: (newValue) {
                            controller.selectLanguage(newValue!);
                          },
                          activeColor: Theme.of(context).colorScheme.primary,
                         )
                      ],)
                  )
                  );
                }).toList())
                ),
            ),
            CustomButton(text: AppLocalizations.of(context)!.confirm, onPressed: () {
              box.write('language', controller.selectedCode.value);
              Get.updateLocale(Locale(controller.selectedCode.value));
              Get.back();
            }),
            SizedBox(height: 20.h)
          ],
        )
        )
    );
  }
}