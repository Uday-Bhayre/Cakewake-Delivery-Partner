import 'package:cakewake_delivery/core/services/api_service.dart';
import 'package:cakewake_delivery/features/authentication/controllers/auth_controller.dart';
import 'package:cakewake_delivery/features/authentication/repository/auth_repositery.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings{
   
   @override
   void dependencies() {
     Get.lazyPut<ApiService>(() => ApiService());
     Get.lazyPut(() => AuthRepository(Get.find<ApiService>()));
     Get.lazyPut<AuthController>(() => AuthController(Get.find<AuthRepository>()));
   }
}