import 'dart:async';
import 'package:cakewake_delivery/features/authentication/model/response.dart';
import 'package:cakewake_delivery/features/authentication/repository/auth_repositery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cakewake_delivery/core/widgets/response_handling.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class OtpController extends GetxController {
  final AuthRepository _authRepository;
  OtpController(this._authRepository);
  final otpCode = ''.obs;
  final timer = 25.obs;
  final formKey = GlobalKey<FormState>();
  Timer? _timer;
  final String phoneNumber = Get.arguments['phone'] as String;
  ResponseModel response = ResponseModel();

  bool isWorkSetupCompleted = false;
  bool isDocumentSetupCompleted = false;
  bool isProfileSetupCompleted = false;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    timer.value = 25;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (timer.value == 0) {
        t.cancel();
      } else {
        timer.value--;
      }
    });
  }

  void onOtpChanged(String value) {
    otpCode.value = value;
  }

  Future<void> resendOtp(String phoneNumber) async {
    startTimer(); // Restart the timer after resending
    await loginOrSignUp();
  }

  Future<void> loginOrSignUp() async {
    EasyLoading.show(status: 'Resending OTP...');
    try {
      response = await _authRepository.sendOtp(
        phoneNumber.replaceFirst('+91', ''),
      );
      ResponseHandling.handleResponse(
        isSuccess: response.success!,
        message: response.message!,
        onSuccess: () {
          Get.toNamed(
            '/otp',
            arguments: {'phone': phoneNumber.replaceFirst('+91', '')},
          );
        },
      );
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> verifyOtpCode() async {
    EasyLoading.show(status: 'Verifying OTP...');
    try {
      response = await _authRepository.verifyOtp(
        phoneNumber,
        otpCode.value.toString(),
      );
      ResponseHandling.handleResponse(
        isSuccess: response.success!,
        message: response.message!,
        onSuccess: () {
         // print(response);
          final box = GetStorage();
          box.write('token', response.token);
          box.write('token_expiry', response.expiry);
          isWorkSetupCompleted =
              response.deliveryPartner?.workSetupId?.isNotEmpty ?? false;
          isDocumentSetupCompleted =
              response.deliveryPartner?.documentSetupId?.isNotEmpty ?? false;
          isProfileSetupCompleted =
              response.deliveryPartner?.profileSetupId?.isNotEmpty ?? false;
          Logger().i(isDocumentSetupCompleted);
          Logger().i(isWorkSetupCompleted);
          Logger().i(isProfileSetupCompleted);
          if (isWorkSetupCompleted &&
              isDocumentSetupCompleted &&
              isProfileSetupCompleted) {
            Get.offAllNamed('/home');
          } else {
            Get.toNamed('/welcome');
          }
        },
      );
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }
}
