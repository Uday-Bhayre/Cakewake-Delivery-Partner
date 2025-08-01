
import 'package:cakewake_delivery/core/services/api_service.dart';
import 'package:cakewake_delivery/features/home/models/order.dart';
import 'package:cakewake_delivery/features/profile_details/models/profile.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeScreenServices{

  final ApiService _apiservice;
  HomeScreenServices(this._apiservice);

  Future<Profile> getProfileData() async{
      try{
        final response= await _apiservice.getItems(endpoint: '/ded');
        return Profile.fromJson(response.data);
      }
      catch(e){
         rethrow;
      }
  }

  late IO.Socket socket;
   final box=GetStorage();

  Future<List<Order>> getOrders(int page,int pagesize) async{
    try{
    final response= await _apiservice.getItems(endpoint: '/orders', params: {
      'page': page,
      'limit': pagesize,
    });

    List<Order> orders=[];
    final data= response.data['orders'];
    
    if (data is List) {
      // If data is a list, map it to Order objects
      orders = data.map((order) => Order.fromJson(order)).toList();
    } else {
      // If data is not a list, return an empty list
      orders = [];
    }
        return orders;
  }
  catch(e){
    rethrow;
  }
  }

  void initSocket(
    {
      required Function(Order order) onOrderAdded,
      required Function(String orderId) onOrderRemoved,
    String? region
    }
  ) {
    socket = IO.io('https://socket-server-8wsr.onrender.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'auth':{'token': box.read('token')},
    });

    socket.onConnect((_){
      Logger().i('Socket connected');
       socket.emit('join-work-area',"gwalior");
    });

    socket.on('order_added',(data){
      final newOrder= Order.fromJson(data);
      onOrderAdded(newOrder);
    });

    socket.on('order_removed',(orderId){
      onOrderRemoved(orderId);
    });

    socket.onDisconnect((_) {
      Logger().i('Socket disconnected');
    });
  }

}