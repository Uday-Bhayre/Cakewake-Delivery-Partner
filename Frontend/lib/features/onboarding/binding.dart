import 'package:cakewake_delivery/features/onboarding/controllers/splash_controller.dart';
import 'package:get/get.dart';

class OnBoardingBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}