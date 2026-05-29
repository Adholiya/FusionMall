import 'package:ecommerce_shop/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce_shop/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecommerce_shop/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce_shop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:ecommerce_shop/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_shop/features/shop/controllers/product_controller.dart';
import 'package:ecommerce_shop/features/shop/screens/all_products/all_products.dart';
import 'package:ecommerce_shop/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:ecommerce_shop/features/shop/screens/home/widgets/home_categories.dart';
import 'package:ecommerce_shop/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:ecommerce_shop/utils/constants/colors.dart';
import 'package:ecommerce_shop/utils/constants/image_strings.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Header
            TPrimaryHeaderContainer(
                child: Column(
              children: [
                //AppBar
                const THomeAppBar(),
                const SizedBox(height: TSizes.spaceBtwSections),
                //SearchBar
                TSearchContainer(text: 'Search in Store'),
                const SizedBox(height: TSizes.spaceBtwSections),
                //Categoroies
                Padding(
                  padding: const EdgeInsets.only(left: TSizes.defaultSpace),
                  child: Column(
                    children: [
                      //Heading
                      TSectionHeading(
                        title: 'Popular Categories',
                        showActionButton: false,
                        textColor: TColors.white,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      //Categories
                      const THomeCategories(),
                    ],
                  ),
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                )
              ],
            )),

            //Body Part
            Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    //Promo Banner or Carousel SLider
                    const TPromoSlider(
                      banners: [
                        TImages.promoBanner1,
                        TImages.promoBanner2,
                        TImages.promoBanner3
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),

                    //Heading
                    TSectionHeading(
                      title: 'Popular Prodcuts',
                      onPressed: () => Get.to(() => const AllProducts()),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),

                    //Popular Products

                    Obx(
                      () => TGridLayout(
                          itemCount: controller.featuredProducts.length,
                          itemBuilder: (_, index) => TProductCardVertical(
                                product: controller.featuredProducts[index],
                              )),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
