import 'dart:async';

import 'package:cakewake_delivery/core/constants/setup_constants.dart';
import 'package:cakewake_delivery/features/home/models/order.dart';
import 'package:cakewake_delivery/features/userProfile/repository/location_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';
import 'package:flutter/services.dart' show rootBundle;

class MapController extends GetxController {
  RxBool isAccessingLocation = false.obs;
  final loc.Location _location = loc.Location();
  Rx<LatLng?> currentLocation = Rx<LatLng?>(null);
  LatLng? pickUpLocation;
  LatLng? dropOffLocation;

  GoogleMapController? _mapController;
  GoogleMapController? get mapController => _mapController;
  RxDouble currentAccuracy = 30.0.obs;
  List<LatLng> _polylineCoordinates = [];
  RxSet<Polyline> _polylines = <Polyline>{}.obs;
  Set<Polyline> get polylines => _polylines.value;
  RxBool isPickedUp = false.obs; // RxBool for pickup status
  RxBool isDelivered = false.obs; // RxBool for delivery status
  RxString routeDistance =''.obs;
  RxString routeDuration = ''.obs;
  String? darkMapStyle;

  StreamSubscription<loc.LocationData>? locationSubscription;

  BitmapDescriptor? blueDotIcon;

  Rx<Order?> currentOrder = Rx<Order?>(null); // Rx<Order> for current order
  RxBool isOrderAccepted = false.obs; // RxBool for order acceptance status

  set mapSet(GoogleMapController? controller) {
    _mapController = controller;
  }

  Future<void> setOrderLocation() async {
    pickUpLocation = await addressToLatLng(currentOrder.value!.pickupAddress);
    dropOffLocation = await addressToLatLng(
      currentOrder.value!.deliveryAddress,
    );
  }

  Future<LatLng?> addressToLatLng(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return LatLng(locations.first.latitude, locations.first.longitude);
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to convert address to coordinates",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
      return null;
    }
  }

  Future<void> _loadBlueDotIcon() async {
    blueDotIcon = await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(24, 24)),
      'assets/images/home/map_dot.png',
    );
  }

  Future<void> initializingMap() async {
    EasyLoading.show(status: 'Loading map..');
    if (blueDotIcon == null) {
      await _loadBlueDotIcon();
    }
      _location.changeSettings(
      accuracy: loc.LocationAccuracy.high,
      interval: 1000, // 1 second 
      distanceFilter: 1, // 1 meter
    );
    await getLocation();
  
    locationChangeUpdate(); // Start listening for location changes after loading the icon
    EasyLoading.dismiss();
  }

  void updateLocationAccess(bool b) {
    isAccessingLocation.value = b;
  }

  Future<void> getLocation() async {
    updateLocationAccess(true);
    if (!await LocationService.instance.checkForAvailability()) {
      Get.snackbar(
        "Error",
        "Location service not enabled",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
      updateLocationAccess(false);
      return;
    }
    if (!await LocationService.instance.permission()) {
      Get.snackbar(
        "Error",
        "Location permission not granted",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
      updateLocationAccess(false);
      return;
    }

    try {
      loc.LocationData locationdata = await _location.getLocation();
      currentLocation.value = LatLng(
        locationdata.latitude!,
        locationdata.longitude!,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to get location",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> updatePolyline() async {
    if (!isPickedUp.value) {
       await getPolyline(currentLocation.value!, pickUpLocation!); // Rider to Pickup
    } else {
      await getPolyline(currentLocation.value!, dropOffLocation!); // Rider to Dropoff
    }
  }

  Future<void> getPolyline(LatLng source, LatLng destination) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: SetupConstants.googleApiKey,
      request: PolylineRequest(
        origin: PointLatLng(source.latitude, source.longitude),
        destination: PointLatLng(destination.latitude, destination.longitude),
        mode: TravelMode.driving,
      ),
    );
    if (result.points.isNotEmpty) {
      _polylineCoordinates.clear();
      for (var point in result.points) {
        _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      _polylines.assignAll({
        Polyline(
          polylineId: const PolylineId("route"),
          color: Colors.blue,
          width: 5,
          points: _polylineCoordinates,
        ),
      });

      final url='https://maps.googleapis.com/maps/api/directions/json?origin=${source.latitude},${source.longitude}&destination=${destination.latitude},${destination.longitude}&key=${SetupConstants.googleApiKey}';
      final response = await Dio().get(url);
      if(response.statusCode==200){
        final data=response.data;
        if(data['routes'].isNotEmpty) {
          final route = data['routes'][0];
          routeDistance.value = route['legs'][0]['distance']['text'];
          routeDuration.value = route['legs'][0]['duration']['text'];
        } else {
          Get.snackbar("Error", "Not able to compute route distance and duration",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red);
        }
      }

    } else {
      Get.snackbar("No Route", "No route found between these points.");
      _polylines.clear();
    };


  }
 bool _isUpdatingPolyline = false;

  void locationChangeUpdate(){
    locationSubscription = _location.onLocationChanged.listen((event) async {
      if (event.latitude == null || event.longitude == null) {
        Get.snackbar(
          "Error",
          "Location data is not available",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
        );
        return;
      }
      // Update the current location with the new coordinates
      currentLocation.value = LatLng(event.latitude!, event.longitude!);
      currentAccuracy.value =
          event.accuracy ?? 30.0; // Default to 30 if accuracy is null
     if (!_isUpdatingPolyline) {
      _isUpdatingPolyline = true;
      await updatePolyline();
      _isUpdatingPolyline = false;
    }  // Update the polyline whenever the location changes
      print('Location updated: ${event.latitude}, ${event.longitude}');
    });
  }

  @override
  void onInit() {
    super.onInit();
    currentOrder.value = Get.arguments['order'];
    setOrderLocation();
      rootBundle.loadString('assets/map_styles/dark_map.json').then((string) {
      darkMapStyle = string;
      });
}
}