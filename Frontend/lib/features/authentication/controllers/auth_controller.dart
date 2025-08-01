import 'package:cakewake_delivery/core/widgets/response_handling.dart';
import 'package:cakewake_delivery/features/authentication/model/response.dart';
import 'package:cakewake_delivery/features/authentication/repository/auth_repositery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository;

  AuthController(this._authRepository);

  RxString phoneNumber = ''.obs;
  final formKey = GlobalKey<FormState>();
  ResponseModel _response = ResponseModel();

  Future<void> loginOrSignUp() async {
     EasyLoading.show(status: 'Loading...');
    try {
      _response = await _authRepository.sendOtp(phoneNumber.value.replaceFirst('+91', ''));
      ResponseHandling.handleResponse(
        isSuccess: _response.success!,
        message: _response.message!,
        onSuccess: () {
          Get.toNamed('/otp', arguments: {'phone': phoneNumber.value.replaceFirst('+91', '')});
        },
      );
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }
}
