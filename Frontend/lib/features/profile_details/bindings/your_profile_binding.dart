import 'package:cakewake_delivery/core/services/api_service.dart';
import 'package:cakewake_delivery/features/profile_details/controllers/your_profile_controller.dart';
import 'package:cakewake_delivery/features/profile_details/repositories/profile_services.dart';
import 'package:get/get.dart';

class YourProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(
      () => ApiService(),
    );
    Get.lazyPut<ProfileServices>(
      () => ProfileServices(Get.find<ApiService>()),
    );
    Get.lazyPut<YourProfileController>(
      () => YourProfileController(Get.find<ProfileServices>()),
    );
  }
}
