import 'package:cakewake_delivery/core/services/api_service.dart';
import 'package:cakewake_delivery/features/userProfile/controllers/profile_controller.dart';
import 'package:cakewake_delivery/features/userProfile/repository/profile_setup_services.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<ProfileSetupServices>(() => ProfileSetupServices(Get.find<ApiService>()));
    Get.lazyPut<ProfileController>(() => ProfileController(Get.find<ProfileSetupServices>()));
  }
}