import 'package:cakewake_delivery/core/widgets/response_handling.dart';
import 'package:cakewake_delivery/features/userProfile/model/response_modal.dart';
import 'package:cakewake_delivery/features/userProfile/repository/document_setup_service.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class DocumentSetupController extends GetxController {
  final DocumentSetupService _documentSetupService;
  DocumentSetupController(this._documentSetupService);

  final aadhaarController = TextEditingController();
  final panController = TextEditingController();
  final aadharKey = GlobalKey<FormState>();
  final panKey = GlobalKey<FormState>();

  Rx<XFile?> capturedImg = Rx<XFile?>(null);
  ResponseModal response = ResponseModal();

  Future<void> saveDocument() async {
    EasyLoading.show(status: 'Saving ...');
    try {
      final data = {
        'aadharNumber': aadhaarController.text,
        'panNumber': panController.text,
      };
        
      final formdata = await getFormData(imageFile: capturedImg.value, data: data);
     
       response = await _documentSetupService.submit(formdata);

      ResponseHandling.handleResponse(
        isSuccess: response.success!,
        message: response.message!,
      );
    } catch (e) {
      
      Logger().e('Error saving document: $e');
      Get.snackbar('Error', 'Failed to save document: $e');
    }
    finally {
      EasyLoading.dismiss();
    }
  }

 Future<dio.FormData> getFormData({required XFile? imageFile, required Map<String, dynamic> data}) async {
  if (imageFile == null) {
    Logger().e('No image selected for upload!');
    throw Exception('No image selected');
  }
  dio.MultipartFile? file;
   file = await dio.MultipartFile.fromFile(
    imageFile.path,
    filename: imageFile.name,
  );
   Logger().i('userImage: ${file.filename}');
    dio.FormData formdata= dio.FormData.fromMap(
      {
        ...data,
        'userImage': file,
      },);
  return formdata;
}

  @override
  void onInit() {
    capturedImg.value = null;
    super.onInit();
  }
}
