import 'package:ecommerce_shop/features/shop/models/product_variation_model.dart';
import 'package:get/get.dart';

class VariationController extends GetxController{
  static VariationController get instance => Get.find();

  // Variables
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation = ProductVariationModel.empty().obs;

  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }
}