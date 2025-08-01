import 'package:cakewake_delivery/core/services/api_service.dart';
import 'package:cakewake_delivery/features/userProfile/controllers/cameraController.dart';
import 'package:cakewake_delivery/features/userProfile/controllers/document_setup_controller.dart';
import 'package:cakewake_delivery/features/userProfile/repository/document_setup_service.dart';
import 'package:get/get.dart';

class CameraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserCameraController>(() => UserCameraController());
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<DocumentSetupService>(
      () => DocumentSetupService(Get.find<ApiService>()),
    );
    Get.lazyPut<DocumentSetupController>(
      () => DocumentSetupController(Get.find<DocumentSetupService>()),
    );
  }
}
