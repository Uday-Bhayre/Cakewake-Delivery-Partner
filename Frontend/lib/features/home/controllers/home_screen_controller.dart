import 'package:cakewake_delivery/features/home/models/order.dart';
import 'package:cakewake_delivery/features/home/repositories/home_services.dart';
import 'package:cakewake_delivery/features/profile_details/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  final HomeScreenServices homeScreenServices;
  HomeScreenController(this.homeScreenServices);

  final RxList<Order> orders = RxList<Order>();
  ScrollController scrollController = ScrollController();
  int _currentPage = 1;
  final int _pageSize = 20;
  bool isLoading = false;
  bool _hasMore = true;
  RxBool isOnline = true.obs;
  RxInt currentIndex = 0.obs;
  RxBool orderAccepted = false.obs;
  Rx<Order?> currentOrder = Rx<Order?>(null);
  void setCurrentOrder(Order? order) {
    currentOrder.value = order;
  }

 Profile? profileData;

  Future<void> profileSet() async {
    EasyLoading.show(status: 'fetching data..');
    try {
      profileData = await homeScreenServices.getProfileData();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Error fetching data",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    } finally {
      EasyLoading.dismiss();
    }
  }

  void orderDetails() {
    Get.toNamed('/orderDetails');
  }

  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      if (!isLoading && _hasMore) {
        fetchOrders();
      }
    }
  }

  void toggleOnlineStatus() {
    isOnline.value = !isOnline.value;
    // Here you can add logic to update the online status in the backend if needed
  }

  Future<void> fetchOrders() async {
    if (isLoading || !_hasMore) return;
    isLoading = true;
    try {
      final newOrders = await homeScreenServices.getOrders(
        _currentPage,
        _pageSize,
      );
      orders.addAll(newOrders);
      if (newOrders.length < _pageSize) {
        _hasMore = false;
      }
      _currentPage++;
    } catch (e) {
      Get.snackbar(
        "Error",
        "Error fetching orders",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading = false;
    }
  }

  void onOrderAdded(Order order) {
    if (!orders.any((orderItem) => orderItem.orderId == order.orderId)) {
      orders.insert(0, order);
    }
  }

  void onOrderRemoved(String orderId) {
    orders.removeWhere((orderItem) => orderItem.orderId == orderId);
  }

  @override
  void onInit() {
    super.onInit();
    //  fetchOrders();
    homeScreenServices.initSocket(
      onOrderAdded: onOrderAdded,
      onOrderRemoved: onOrderRemoved,
      region: null,
    );
    orders.addAll([
      Order(
        orderId: "1234567",
        customerName: "Priyanshu Gupta",
        pickupAddress: "ABV-IIITM, Gwalior, Madhya Pradesh",
        deliveryAddress: "Old housing board,Rewari, Haryana",
        customerPhone: "+91 9876543210",
        earning: "₹999",
        estimatedTime: "23",
      ),
      Order(
        orderId: "1234568",
        customerName: "Ankit Sharma",
        pickupAddress: "CakeZone, Sector 21",
        deliveryAddress: "Sunshine Apartments, Sector 45, Gurgaon",
        customerPhone: "+91 9123456780",
        earning: "₹799",
        estimatedTime: "18",
      ),
    ]);
    scrollController.addListener(_scrollListener);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
