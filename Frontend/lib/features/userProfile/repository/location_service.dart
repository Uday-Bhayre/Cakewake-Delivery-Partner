import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class LocationService {

  LocationService._internal();
  static final LocationService instance = LocationService._internal();

  Location _location = Location();

  Future<bool> checkForAvailability() async {
     bool isEnabled= await _location.serviceEnabled();

     if(!isEnabled){
      isEnabled= await _location.requestService();
     }
     return isEnabled;
  }


  Future<PermissionStatus>  checkPermission() async{
    PermissionStatus status= await _location.hasPermission();

    if(status==PermissionStatus.denied){
      status= await _location.requestPermission();
    }
    return status;
  }

  Future<bool> permission() async {
    //1. initial check for permission
    PermissionStatus status= await checkPermission();

    //2. already granted
    if(status==PermissionStatus.granted){
      return true;
    }

    if(status==PermissionStatus.denied){

      status= await _location.requestPermission();

      if(status==PermissionStatus.granted){
        return true;
      }

      if(status==PermissionStatus.deniedForever){
        //show dialog to user
        return  openAppSettings();
      }
    }
    //3. denied forever
    return openAppSettings();
  }


  Future<bool> openAppSettings() async  {
    bool isOpened= await Get.dialog(
      AlertDialog(
        title: const Text('Location Permission'),
        content: const Text(
      'You have denied location permission multiple times.\n'
      'To enable it:\n'
      '1. Open Settings\n'
      '2. Go to Apps > cakewake Delivery Partner app\n'
      '3. Tap Permissions\n'
      '4. Tap Location under "Not allowed"\n'
      '5. Select Allow only while using the app',
        ),
        actions: [
          TextButton(
          child: const Text('Ok'),
          onPressed: () {
           Get.back(result: true);
          },
        ),
        ],
      )
    );
     if(isOpened){
    final newstatus= await checkPermission();
    if(newstatus==PermissionStatus.granted){
      return true;
    }
    return false;
  }
  return false;
  }
}