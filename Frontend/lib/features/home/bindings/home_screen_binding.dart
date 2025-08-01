import 'package:cakewake_delivery/core/services/api_service.dart';
import 'package:cakewake_delivery/features/home/controllers/home_screen_controller.dart';
import 'package:cakewake_delivery/features/home/repositories/home_services.dart';
import 'package:get/get.dart';
class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<HomeScreenServices>(() => HomeScreenServices(Get.find<ApiService>()));
    Get.put<HomeScreenController>(HomeScreenController(Get.find<HomeScreenServices>()),
       permanent: true);
  }
}
