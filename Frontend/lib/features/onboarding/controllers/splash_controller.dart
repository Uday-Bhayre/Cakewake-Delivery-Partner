import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    final box = GetStorage();
    final isCompleted = box.read('onboardingCompleted') ?? false;
    String? token=box.read('token');
    String? expiry=box.read('token_expiry');

     await Future.delayed(const Duration(seconds: 3),(){
      Get.offNamed('/home');
    //    if (isCompleted) {
    //     if(token!=null && expiry!=null)
    //     {
    //       final expirydate=DateTime.parse(expiry);
    //       if(DateTime.now().isBefore(expirydate))
    //       {
    //         Get.offNamed('/home');
    //       }
    //       else{
    //         Get.offNamed('/authentication');
    //       }
    //     }
    //   Get.offNamed('/authentication');
    // } else {
    //   Get.offNamed('/onboarding');
    // }
     });
  }
}