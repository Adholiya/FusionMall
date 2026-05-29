import 'package:ecommerce_shop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce_shop/common/widgets/icon/t_circular_icon.dart';
import 'package:ecommerce_shop/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce_shop/common/widgets/products/price/product_price_text.dart';
import 'package:ecommerce_shop/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce_shop/common/widgets/texts/t_brand_title_with_verified_icon.dart';
import 'package:ecommerce_shop/utils/constants/colors.dart';
import 'package:ecommerce_shop/utils/constants/image_strings.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:ecommerce_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        color: dark ? TColors.darkerGrey : TColors.lightContainer,
      ),
      child: Row(
        children: [
          //Thumbnail
          TRoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: dark ? TColors.dark : TColors.light,
            child: Stack(
              children: [
                //Thumbnail
                SizedBox(
                  height: 120,
                  width: 120,
                  child: TRoundedImage(
                    imageUrl: TImages.productIamge1,
                    applyImageRadius: true,
                  ),
                ),
                //Sale Tag
                Positioned(
                  top: 12,
                  child: TRoundedContainer(
                    radius: TSizes.sm,
                    backgroundColor: TColors.secondary.withOpacity(0.8),
                    padding: EdgeInsets.symmetric(
                        horizontal: TSizes.sm, vertical: TSizes.xs),
                    child: Text(
                      '25%',
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
                    height: 40,
                    width: 40,
                    child: TCircularIcon(
                      icon: Iconsax.heart5,
                      color: Colors.red,
                    ))
              ],
            ),
          ),

          //Details
          SizedBox(
            width: 172,
            child: Padding(
              padding: const EdgeInsets.only(top: TSizes.sm, left: TSizes.sm),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TProductTitleText(
                        title: 'Half Shirt for Men Check',
                        smallSize: true,
                      ),
                      SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      TBrandTitleWithVerifiedIcon(title: 'Gloryboyz')
                    ],
                  ),

                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Pricing
                      Flexible(child: TProductPriceText(price: '599')),

                      //Add to Cart
                      Container(
                        decoration: const BoxDecoration(
                            color: TColors.dark,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(TSizes.cardRadiusMd),
                                bottomRight: Radius.circular(
                                    TSizes.productImageRadius))),
                        child: const SizedBox(
                            width: TSizes.iconLg * 1.2,
                            height: TSizes.iconLg * 1.2,
                            child: Center(
                              child: Icon(
                                Iconsax.add,
                                color: TColors.white,
                              ),
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
