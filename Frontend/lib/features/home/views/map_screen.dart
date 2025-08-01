import 'dart:math';

import 'package:cakewake_delivery/features/home/controllers/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final controller = Get.find<MapController>();

  void dispose() {
    controller.locationSubscription
        ?.cancel(); // Cancel location updates when screen is closed
      
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: Obx(
        () =>
            controller.currentLocation.value == null
                ? const Center(child: CircularProgressIndicator())
                : Stack(
                  children:[ GoogleMap(
                    key: ValueKey(Theme.of(context).brightness), // <-- Add this line
                    initialCameraPosition: CameraPosition(
                      target: controller.currentLocation.value!,
                      zoom: 13.0,
                    ),
                    style: Theme.of(context).brightness == Brightness.dark
                        ? controller.darkMapStyle
                        : null,
                    onMapCreated: (control) async {
                      controller.mapSet = control;
                  
                      await Future.delayed(const Duration(milliseconds: 300));
                  
                      final bounds = LatLngBounds(
                        southwest: LatLng(
                          min(
                            controller.currentLocation.value!.latitude,
                            controller.pickUpLocation!.latitude,
                          ),
                          min(
                            controller.currentLocation.value!.longitude,
                            controller.pickUpLocation!.longitude,
                          ),
                        ),
                        northeast: LatLng(
                          max(
                            controller.currentLocation.value!.latitude,
                            controller.pickUpLocation!.latitude,
                          ),
                          max(
                            controller.currentLocation.value!.longitude,
                            controller.pickUpLocation!.longitude,
                          ),
                        ),
                      );
                      controller.mapController!.animateCamera(
                        CameraUpdate.newLatLngBounds(bounds, 70),
                      );
                    },
                    markers: {
                      Marker(
                        markerId: MarkerId("current_location_marker"),
                        icon:
                            controller.blueDotIcon ??
                            BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueBlue,
                            ),
                        position: controller.currentLocation.value!,
                        infoWindow: InfoWindow(title: "You"),
                      ),
                      Marker(
                        markerId: MarkerId("pickup_marker"),
                        icon: BitmapDescriptor.defaultMarker,
                        position: controller.pickUpLocation!,
                        infoWindow: InfoWindow(title: "Pickup Location"),
                      ),
                      Marker(
                        markerId: MarkerId("dropoff_marker"),
                        icon: BitmapDescriptor.defaultMarker,
                        position: controller.dropOffLocation!,
                        infoWindow: InfoWindow(title: "Dropoff Location"),
                      ),
                    },
                    circles: {
                      Circle(
                        circleId: CircleId("accuracy_circle"),
                        center: controller.currentLocation.value!,
                        radius: controller.currentAccuracy.value!,
                        fillColor: Colors.blue.withAlpha(20),
                        strokeColor: Colors.blue.withAlpha(50),
                        strokeWidth: 1,
                      ),
                    },
                    polylines: controller.polylines,
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child:Obx(() =>controller.routeDistance.value.isNotEmpty && controller.routeDuration.value.isNotEmpty
                        ? Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(10),
                                  blurRadius: 5.0,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              'Distance: ${controller.routeDistance.value}\nDuration: ${controller.routeDuration.value}',
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : const SizedBox.shrink()),
                  )
                  ]
                ),
      ),
    );
  }
}
