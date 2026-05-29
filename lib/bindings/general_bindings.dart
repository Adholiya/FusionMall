import 'package:ecommerce_shop/features/shop/controllers/variation_controller.dart';
import 'package:ecommerce_shop/utils/network/network_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
  }
  
}