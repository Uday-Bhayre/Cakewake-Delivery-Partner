import 'package:cakewake_delivery/core/widgets/response_handling.dart';
import 'package:cakewake_delivery/features/userProfile/model/profile_setup.dart';
import 'package:cakewake_delivery/features/userProfile/model/response_modal.dart';
import 'package:cakewake_delivery/features/userProfile/repository/profile_setup_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ProfileController extends GetxController {

  final ProfileSetupServices _profileSetupServices;
  ProfileController(this._profileSetupServices);

  RxString selectedCode='en'.obs;

  void selectLanguage(String code) {
    selectedCode.value= code;
  }
  final formKey= GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  RxString selectedGender = ''.obs;


  final accountNo= TextEditingController();
  final reAccountNo= TextEditingController();
  RxString selectedBank = ''.obs;
  final bankNameController = TextEditingController();
  final bankFormKey = GlobalKey<FormState>();
   ResponseModal response= ResponseModal();
   final ifsc=TextEditingController();

    Future<void> submitProfile() async {
       try{
        final profileSetup = ProfileSetup(
          name: nameController.text,
          email: emailController.text,
          gender: selectedGender.value,
          accountHolderName: bankNameController.text,
          accountNo: accountNo.text,
          bankName: selectedBank.value,
          ifsc: ifsc.text,
        );
        Logger().i(profileSetup.toJson());
        response= await _profileSetupServices.submitProfile(profileSetup);
        
        ResponseHandling.handleResponse(
          isSuccess: response.success!,
          message: response.message!,
         
        );

       }
       catch (e) {
         Get.snackbar('Error', 'Failed to submit profile: $e',
           snackPosition: SnackPosition.TOP,
           backgroundColor: Colors.red,
           colorText: Colors.white,
         );
       }
    }
}