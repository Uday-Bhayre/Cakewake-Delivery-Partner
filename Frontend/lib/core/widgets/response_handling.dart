import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponseHandling {

  static handleResponse({
    required bool isSuccess,
    required String message,
    VoidCallback? onSuccess,
  }) {
    if (isSuccess) {
      Get.snackbar(
        'Success',
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      if (onSuccess != null) {
        onSuccess();
      }
    } else {
      Get.snackbar(
        'Error',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
