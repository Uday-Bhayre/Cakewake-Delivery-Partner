import 'package:cakewake_delivery/core/widgets/response_handling.dart';
import 'package:cakewake_delivery/features/userProfile/model/response_modal.dart';
import 'package:cakewake_delivery/features/userProfile/repository/location_service.dart';
import 'package:cakewake_delivery/features/userProfile/repository/work_setup_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;

class WorkSetupController extends GetxController {
  final WorkSetupService _workSetupService;
  WorkSetupController(this._workSetupService);

  RxBool isAcessingLocation = false.obs;
  RxString errorDescription = ''.obs;
  Rx<loc.LocationData?> data = Rx<loc.LocationData?>(null);
  RxString cityName = ''.obs;
  var areas = <String>[].obs;
  RxString selectedArea = ''.obs;
  var filteredAreas = <String>[].obs;

  var allCities = <Map<String, String>>[].obs;
  var filterCities = <Map<String, String>>[].obs;
  RxString searchText = ''.obs;
  RxString selectedCity = ''.obs;
  RxString selectedVehicle = ''.obs;
  final TextEditingController vehicleColorController = TextEditingController();
  final TextEditingController vehicleNumberController = TextEditingController();
  RxString manufacturingYear = ''.obs;
  Rx<XFile?> rcImage = Rx<XFile?>(null);
  Rx<XFile?> insuranceImg = Rx<XFile?>(null);
  RxString selectedWorkTiming = ''.obs;

  final vehicleFormKey = GlobalKey<FormState>();

  final loc.Location _location = loc.Location();

  void updateLocationData(loc.LocationData? locationData) {
    data.value = locationData;
  }

  void updateLocationAccess(bool b) {
    isAcessingLocation.value = b;
  }

  Future<bool> getLocation() async {
    updateLocationAccess(true);

    if (!(await LocationService.instance.checkForAvailability())) {
      errorDescription.value = "Location service not enabled";
      updateLocationAccess(false);
      return false;
    }

    if (!(await LocationService.instance.permission())) {
      errorDescription.value = "Location permission not granted";
      updateLocationAccess(false);
      return false;
    }

    try {
      final loc.LocationData locationData = await _location.getLocation();
      updateLocationData(locationData);
      updateLocationAccess(false);
      return true;
    } catch (e) {
      errorDescription.value = "Failed to get location";
      updateLocationAccess(false);
      return false;
    }
  }

  Future<void> getCityFromLocation() async {
    if (data.value == null) {
      errorDescription.value = "Location data is not available";
      return;
    }

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        data.value!.latitude!,
        data.value!.longitude!,
      );

      if (placemarks.isNotEmpty) {
        cityName.value = placemarks.first.locality!;
        selectedCity.value = cityName.value;
      } else {
        errorDescription.value = "No city found for the given location";
        return;
      }
    } catch (e) {
      errorDescription.value = "Failed to get city from location";
      return;
    }
  }

  void loadCities() async {
    final cities = await _workSetupService.loadCitiesFromCSV();
    allCities.value = cities;
    filterCities.value = cities;
  }

  void filterCitiesBySearch(String searchText) {
    if (searchText.isEmpty) {
      filterCities.value = allCities;
    } else {
      filterCities.value =
          allCities.where((city) {
            return city['city_ascii']!.toLowerCase().contains(
              searchText.toLowerCase(),
            );
          }).toList();
    }
  }

  void selectCity(String city) {
    selectedCity.value = city;
  }

  void loadAreas() async {
    final city = await _workSetupService.cityAreas.firstWhere((value) {
      return value['city'].toString().toLowerCase() ==
          selectedCity.value.toLowerCase();
    }, orElse: () => {});
    areas.value = List<String>.from(city['areas'] ?? []);
    filteredAreas.value = areas;
  }

  void filterAreasbySearch(String searchText) {
    if (searchText.isEmpty) {
      filteredAreas.value = areas;
    } else {
      filteredAreas.value =
          areas.where((area) {
            return area.toLowerCase().contains(searchText.toLowerCase());
          }).toList();
    }
  }

  void selectArea(String area) {
    selectedArea.value = area;
  }

  void selectVehicle(String vehicle) {
    selectedVehicle.value = vehicle;
  }

  void selectWorkTiming(String workTiming) {
    selectedWorkTiming.value = workTiming;
  }

  Future<void> pickImg(BuildContext context, Rx<XFile?> imageFile) async {
    final ImagePicker picker = ImagePicker();
    showModalBottomSheet(
      context: context,
      builder:
          (_) => SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Camera'),
                  onTap: () async {
                    Navigator.pop(context);
                    final picked = await picker.pickImage(
                      source: ImageSource.camera,
                    );
                    if (picked != null) imageFile.value = picked;
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Gallery'),
                  onTap: () async {
                    Navigator.pop(context);
                    final picked = await picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (picked != null) imageFile.value = picked;
                  },
                ),
              ],
            ),
          ),
    );
  }

  ResponseModal response = ResponseModal();
  Future<void> submitWorkSetup() async {
    EasyLoading.show(status: 'Submitting work setup...');
    try {
      Map<String, dynamic> workSetup = {
        'workCity': selectedCity.value,
        'workArea': selectedArea.value,
        'vehicleType': selectedVehicle.value,
        'vehicleColor': vehicleColorController.text,
        'manufacturing_year': manufacturingYear.value,
        'vehicleNumber': vehicleNumberController.text,
        'workTimings': selectedWorkTiming.value,
      };

      dio.FormData formData = await getFormData(
        rcImage: rcImage.value,
        insuranceImg: insuranceImg.value,
        workSetup: workSetup,
      );
      response = await _workSetupService.submit(formData);
      ResponseHandling.handleResponse(
        isSuccess: response.success!,
        message: response.message!,
    
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to submit work setup: $e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<dio.FormData> getFormData({
    required XFile? rcImage,
    required XFile? insuranceImg,
    required Map<String, dynamic> workSetup,
  }) async {
    dio.MultipartFile? rcFile;
    dio.MultipartFile? insuranceFile;

    if (rcImage != null) {
      rcFile = await dio.MultipartFile.fromFile(
        rcImage.path,
        filename: rcImage.name,
      );
    }
    if (insuranceImg != null) {
      insuranceFile = await dio.MultipartFile.fromFile(
        insuranceImg.path,
        filename: insuranceImg.name,
      );
    }

    dio.FormData formData = dio.FormData.fromMap({
      ...workSetup,
      if (rcFile != null) 'rcImage': rcFile,
      if (insuranceFile != null) 'insuranceImg': insuranceFile,
    });

    return formData;
  }

  @override
  void onInit() {
    super.onInit();
    getLocation().then((_) {
      if (data.value != null) {
        getCityFromLocation();
      }
    });
    loadCities();
  }
}
