import 'package:ecommerce_shop/data/repositories/brands/brand_repository.dart';
import 'package:ecommerce_shop/features/shop/models/brand_model.dart';
import 'package:ecommerce_shop/utils/network/loaders.dart';
import 'package:get/get.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  RxBool isLoading = true.obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final brandRepository = Get.put(BrandRepository());

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  // Load Brands
  Future<void> getFeaturedBrands() async {
    try {
      // Show Loader while loading brands
      isLoading.value = true;

      final brands = await brandRepository.getAllBrands();

      allBrands.assignAll(brands);

      featuredBrands.assignAll(
          allBrands.where((brand) => brand.isFeatured ?? false).take(4));
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      // Stop Loader
      isLoading.value = false;
    }
  }

  // Get brands for your category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      final brands = await brandRepository.getBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      // TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return[];
    }
  }

}
