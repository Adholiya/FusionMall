import 'package:ecommerce_shop/common/styles/shadows.dart';
import 'package:ecommerce_shop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce_shop/common/widgets/icon/t_circular_icon.dart';
import 'package:ecommerce_shop/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce_shop/common/widgets/products/price/product_price_text.dart';
import 'package:ecommerce_shop/common/widgets/products/product_cards/add_to_cart_button.dart';
import 'package:ecommerce_shop/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce_shop/common/widgets/texts/t_brand_title_with_verified_icon.dart';
import 'package:ecommerce_shop/features/shop/models/product_model.dart';
import 'package:ecommerce_shop/features/shop/screens/product_details/product_detail.dart';
import 'package:ecommerce_shop/utils/constants/colors.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:ecommerce_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    // final controller = ProductController.instance;
    // final salePercentage = controller.calculateSalePercentage();
    final dark = THelperFunctions.isDarkMode(context);
    //Container with side padding, , color, edges, shadow, etcc
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen()),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkGrey : TColors.white,
        ),
        child: Column(
          children: [
            //Thumbnail, Wishlist Button, Discount Tag
            TRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  // Thumbnail Image
                  TRoundedImage(
                    imageUrl: product.thumbnail,
                    applyImageRadius: true,
                  ),

                  //Sale Tag
                  Positioned(
                    top: 12,
                    child: TRoundedContainer(
                      radius: TSizes.sm,
                      backgroundColor: TColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm, vertical: TSizes.xs),
                      child: Text(
                        '${(((product.price - product.salePrice) / product.price) * 100).floorToDouble()}',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: TColors.black),
                      ),
                    ),
                  ),

                  //Favourite Icon Button
                  Positioned(
                      top: 0,
                      right: 0,
                      child: const TCircularIcon(
                        icon: Iconsax.heart5,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),

            //Details

            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TProductTitleText(
                    title: product.title,
                    smallSize: true,
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  TBrandTitleWithVerifiedIcon(
                    title: product.brand?.name ?? 'Nike',
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Price, show sale price as main price if sale exists
                Padding(
                  padding: const EdgeInsets.only(left: TSizes.sm),
                  child: TProductPriceText(
                    price: '${product.salePrice}',
                  ),
                ),

                //Add to Cart
                ProductCardAddToCartButton(product: product),
              ],
            )
          ],
        ),
      ),
    );
  }
}
