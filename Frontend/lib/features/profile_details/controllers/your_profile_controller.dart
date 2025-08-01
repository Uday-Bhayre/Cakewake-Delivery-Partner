import 'package:cakewake_delivery/core/widgets/response_handling.dart';
import 'package:cakewake_delivery/features/home/controllers/home_screen_controller.dart';
import 'package:cakewake_delivery/features/profile_details/repositories/profile_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;

class YourProfileController extends GetxController {
   
   final ProfileServices profileServices;
   YourProfileController(this.profileServices);

   final controller2= Get.find<HomeScreenController>();
   Rx<XFile?> profileImage = Rx<XFile?>(null);
    final ImagePicker _picker = ImagePicker();
   
    Future<void> pickProfileImg() async{
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        profileImage.value = image;
        controller2.profileData!.profileImage=image;
      }
    }

    Future<void> updateProfile() async {
      EasyLoading.show(status: 'Updating profile...');
      try{
        final formData = await getProfileFormData();
           final response = await profileServices.submitProfile(formData);
           ResponseHandling.handleResponse(
            isSuccess: response.success!, 
            message: response.message!);
      }
      catch(e){
        Get.snackbar("Error", "Failed to update profile",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
        );
      } finally{
        EasyLoading.dismiss();
      }
    }

     Future<dio.FormData> getProfileFormData()async{
      dio.MultipartFile? profileFile;
      if(profileImage.value != null){
        profileFile = await dio.MultipartFile.fromFile(profileImage.value!.path);
      }
      return dio.FormData.fromMap({
        'profile_image': profileFile,
      });
    }

    String maskAccountNumber(String account){
      final visibleStart = account.substring(0, 2);
      final visibleEnd = account.substring(account.length - 2);
      final maskedPart = '*' * (account.length - 4);
        return '$visibleStart$maskedPart$visibleEnd';
      }

       
    void onInit(){
      super.onInit();
      if (controller2.profileData != null) {
        profileImage.value = controller2.profileData!.profileImage;
    }
    else {
        profileImage.value = null; // or set a default image
      }
    }
}