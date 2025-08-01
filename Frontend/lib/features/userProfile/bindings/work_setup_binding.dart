import 'package:cakewake_delivery/core/services/api_service.dart';
import 'package:cakewake_delivery/features/userProfile/controllers/work_setupcontroller.dart';
import 'package:cakewake_delivery/features/userProfile/repository/work_setup_service.dart';
import 'package:get/get.dart';

class WorkSetupBinding extends Bindings{

  @override
  void dependencies(){
    Get.lazyPut<ApiService>(()=> ApiService());
    Get.lazyPut<WorkSetupService>(() => WorkSetupService(Get.find<ApiService>()));
    Get.lazyPut<WorkSetupController>(() => WorkSetupController(Get.find<WorkSetupService>()));
  }
}