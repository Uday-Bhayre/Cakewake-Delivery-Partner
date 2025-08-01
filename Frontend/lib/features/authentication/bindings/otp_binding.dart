
import 'package:cakewake_delivery/core/services/api_service.dart';
import 'package:cakewake_delivery/features/authentication/controllers/otp_controller.dart';
import 'package:cakewake_delivery/features/authentication/repository/auth_repositery.dart';
import 'package:get/get.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(()=> ApiService());
    Get.lazyPut(() => AuthRepository(Get.find<ApiService>()));
    Get.put<OtpController>( OtpController(Get.find<AuthRepository>()),permanent: true);
  }
}