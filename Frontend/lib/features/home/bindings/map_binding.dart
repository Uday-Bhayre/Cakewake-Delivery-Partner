import 'package:cakewake_delivery/features/home/controllers/map_controller.dart';
import 'package:get/get.dart';

class MapBinding extends Bindings{

  @override
  void dependencies(){
    Get.lazyPut<MapController>(()=> MapController());
  }
}