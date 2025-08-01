import 'package:cakewake_delivery/features/authentication/bindings/binding.dart';
import 'package:cakewake_delivery/features/authentication/bindings/otp_binding.dart';
import 'package:cakewake_delivery/features/home/bindings/home_screen_binding.dart';
import 'package:cakewake_delivery/features/home/bindings/map_binding.dart';
import 'package:cakewake_delivery/features/home/views/home_screen.dart';
import 'package:cakewake_delivery/features/home/views/map_screen.dart';
import 'package:cakewake_delivery/features/home/views/order_details_screen.dart';
import 'package:cakewake_delivery/features/profile_details/bindings/your_profile_binding.dart';
import 'package:cakewake_delivery/features/profile_details/views/bank_info_screen.dart';
import 'package:cakewake_delivery/features/profile_details/views/profile_screen.dart';
import 'package:cakewake_delivery/features/profile_details/views/vehicle_details_screen.dart';
import 'package:cakewake_delivery/features/profile_details/views/your_profile_screen.dart';
import 'package:cakewake_delivery/features/userProfile/bindings/camera_binding.dart';
import 'package:cakewake_delivery/features/userProfile/bindings/document_setup_binding.dart';
import 'package:cakewake_delivery/features/userProfile/views/documents/aadhaar_screen.dart';
import 'package:cakewake_delivery/features/userProfile/views/documents/document_pic_screen.dart';
import 'package:cakewake_delivery/features/userProfile/views/documents/pancard_screen.dart';
import 'package:cakewake_delivery/features/userProfile/views/profile%20setup/bank_details_screen.dart';
import 'package:cakewake_delivery/features/userProfile/views/profile%20setup/email_info_screen.dart';
import 'package:cakewake_delivery/features/authentication/view/mobile_auth.dart';
import 'package:cakewake_delivery/features/authentication/view/otp_verification_screen.dart';
import 'package:cakewake_delivery/features/onboarding/binding.dart';
import 'package:cakewake_delivery/features/onboarding/views/onboarding_screen.dart';
import 'package:cakewake_delivery/features/onboarding/views/splashscreen.dart';
import 'package:cakewake_delivery/features/userProfile/bindings/profile_binding.dart';
import 'package:cakewake_delivery/features/userProfile/bindings/work_setup_binding.dart';
import 'package:cakewake_delivery/features/userProfile/views/language_screen.dart';
import 'package:cakewake_delivery/features/userProfile/views/welcome_screen.dart';
import 'package:cakewake_delivery/features/userProfile/views/work%20setup/vehicle_details_screen.dart';
import 'package:cakewake_delivery/features/userProfile/views/work%20setup/location.dart';
import 'package:cakewake_delivery/features/userProfile/views/work%20setup/upload_insuarance_screen.dart';
import 'package:cakewake_delivery/features/userProfile/views/work%20setup/upload_rc_screen.dart';
import 'package:cakewake_delivery/features/userProfile/views/work%20setup/vehicle_screen.dart';
import 'package:cakewake_delivery/features/userProfile/views/work%20setup/work_area_screen.dart';
import 'package:cakewake_delivery/features/userProfile/views/work%20setup/work_city_screen.dart';
import 'package:cakewake_delivery/features/userProfile/views/work%20setup/work_timing_screen.dart';
import 'package:get/get.dart';

class AppRoute {
  static final routes = [
    GetPage(
      name: '/splash',
      page: () => SplashScreen(),
      binding: OnBoardingBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/onboarding',
      page: () =>  OnBoardingScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/authentication',
      page: () => MobileAuth(),
      transition: Transition.fadeIn,
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/otp',
      page: () => OtpScreen(phoneNumber: ''),
      binding: OtpBinding(),
    ),
    GetPage(
      name: '/userinfo',
      page: () => UserInfoScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/language',
      page: () => LanguageSelectionScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: '/welcome',
      page: () => WelcomeScreen(),
      binding: WorkSetupBinding(),
    ),
    GetPage(
      name: '/location',
      page: () => LocationScreen(),
      binding: WorkSetupBinding(),
    ),
    GetPage(
      name: '/workcity',
      page: () => WorkCityScreen(),
      binding: WorkSetupBinding(),
    ),
    GetPage(
      name: '/workarea',
      page: () => WorkAreaScreen(),
      binding: WorkSetupBinding(),
    ),
    GetPage(
      name: '/vehicle',
      page: () => VehicleScreen(),
      binding: WorkSetupBinding(),
    ),
    GetPage(
      name: '/vehicleDetails',
      page: () => VehicleDetailsScreen(),
      binding: WorkSetupBinding(),
    ),
    GetPage(
      name: '/rcScreen',
      page: () => UploadRcScreen(),
      binding: WorkSetupBinding(),
    ),
    GetPage(
      name: '/uploadInsurance',
      page: () => UploadInsuranceScreen(),
      binding: WorkSetupBinding(),
    ),
    GetPage(
      name: '/workTiming',
      page: () => WorkTimingScreen(),
      binding: WorkSetupBinding(),
    ),
    GetPage(
      name: '/profile',
      page: () => UserInfoScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: '/aadhaar',
      page: () => AadhaarScreen(),
      binding: DocumentSetupBinding(),
    ),
    GetPage(
      name: '/bankDetails',
      page: () => BankDetailsScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: '/documentPic',
      page: () => DocumentPicScreen(),
      binding: CameraBinding(),
    ),
    GetPage(
      name: '/pancard',
      page: () => PancardScreen(),
      binding: DocumentSetupBinding(),
    ),
    GetPage(
      name: '/home', 
      page: () => HomeScreen(),
      binding: HomeScreenBinding(),
    ),
    GetPage(
      name: '/mapScreen',
      page: () => MapScreen(),
       binding: MapBinding(),
    ),
    GetPage(
      name: '/orderDetails',
      page: () => OrderDetailsScreen(),
       binding: MapBinding(),
    ),

    //Profile related routes
    GetPage(
      name: '/profilePage',
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: '/yourProfile',
      page: () => YourProfileScreen(),
      binding: YourProfileBinding(),
    ),
    GetPage(
      name: '/vehicleInformation',
      page: () => FinalVehicleDetailsScreen(),
    ),
    GetPage(
      name: '/bankInfo',
      page: () => BankInfoScreen(),
      binding: YourProfileBinding(),
    )
  ];
}
  