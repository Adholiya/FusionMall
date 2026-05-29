import 'package:ecommerce_shop/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_shop/common/widgets/appbar/tabbar.dart';
import 'package:ecommerce_shop/common/widgets/brand/brand_card.dart';
import 'package:ecommerce_shop/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecommerce_shop/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce_shop/common/widgets/products_cart/cart_menu_icon.dart';
import 'package:ecommerce_shop/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_shop/features/shop/controllers/brand_controller.dart';
import 'package:ecommerce_shop/features/shop/controllers/category_controller.dart';
import 'package:ecommerce_shop/features/shop/screens/brand/all_brands.dart';
import 'package:ecommerce_shop/features/shop/screens/store/widgets/category_tab.dart';
import 'package:ecommerce_shop/utils/constants/brand_shimmer.dart';
import 'package:ecommerce_shop/utils/constants/colors.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:ecommerce_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());
    final categories = CategoryController.instance.featuredCategories;
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            TCartCounterIcon(
            )
          ],
        ),
        body: NestedScrollView(
            headerSliverBuilder: (_, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: true,
                    backgroundColor: THelperFunctions.isDarkMode(context)
                        ? TColors.black
                        : TColors.white,
                    expandedHeight: 440,
                    flexibleSpace: Padding(
                      padding: EdgeInsets.all(TSizes.defaultSpace),
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          TSearchContainer(
                            text: 'Search In Store',
                            showBorder: true,
                            showBackground: false,
                            padding: EdgeInsets.zero,
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),

                          //Feature Brands
                          TSectionHeading(
                            title: 'Featured Brands',
                            onPressed: () =>
                                Get.to(() => const AllBrandsScreen()),
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems / 1.5,
                          ),

                          // Brand Grid
                          Obx(() {
                            if (brandController.isLoading.value) {
                              return const TBrandsShimmer();
                            }

                            if (brandController.featuredBrands.isEmpty) {
                              return Center(
                                child: Text(
                                  'No Data Found!',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .apply(color: Colors.white),
                                ),
                              );
                            }

                            return TGridLayout(
                                itemCount: brandController.featuredBrands.length,
                                mainAxisExtent: 80,
                                itemBuilder: (_, index) {
                                  final brand = brandController.featuredBrands[index];
                                  return TBrandCard(
                                      brand: brand, showBorder: true);
                                });
                          })
                        ],
                      ),
                    ),
                    //Tabs

                    bottom: TTabBar(
                        tabs: categories
                            .map((category) => Tab(child: Text(category.name)))
                            .toList())),
              ];
            },
            body: TabBarView(
                children: categories
                    .map((category) => TCategoryTab(category: category))
                    .toList())),
      ),
    );
  }
}
