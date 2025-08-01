import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:logger/logger.dart';

class UserCameraController extends GetxController {

    late CameraController cameraController;
    RxBool isCameraInitialized = false.obs;


    Future<void> _initCamera() async{
      var status= await Permission.camera.request();
      if(!status.isGranted)
      {
        Get.snackbar('Camera Permission', 'Camera access is required to use this feature.');
        return;
      }
      try{
        final cameras= await availableCameras();
        final frontCamera = cameras.firstWhere(
          (c)=>c.lensDirection==CameraLensDirection.front,
          orElse:()=> cameras.first
          );
          cameraController = CameraController(
            frontCamera,
            ResolutionPreset.medium,
            enableAudio: false,
          );
          await cameraController.initialize();
          isCameraInitialized.value = true;
      }
      catch(e){
        Logger().e('Error initializing camera: $e');
        Get.snackbar('Error', 'Failed to initialize camera:',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
        );
      }
    }

    Future<XFile?> captureImg() async{
      if(!isCameraInitialized.value) return null;
      try{
          return await cameraController.takePicture();
      }
      catch(e)
      {
        Logger().e('Error capturing image: $e');
        Get.snackbar('Error', 'Failed to capture image:',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
        );
        return null;
      }
    }

    @override
    void onInit(){
      _initCamera();
      super.onInit();
    }
    @override
    void onClose(){
      if(isCameraInitialized.value)
      {
        cameraController.dispose();
        isCameraInitialized.value = false;
      }
      super.onClose();
    }
}