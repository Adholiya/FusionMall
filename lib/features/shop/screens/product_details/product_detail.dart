import 'package:ecommerce_shop/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_shop/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:ecommerce_shop/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:ecommerce_shop/features/shop/screens/product_details/widgets/product_detail_image.dart';
import 'package:ecommerce_shop/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:ecommerce_shop/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:ecommerce_shop/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  // final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Image Slider
            TProductImageSlider(),

            // Product Details
            Padding(
              padding: EdgeInsets.only(
                right: TSizes.defaultSpace,
                left: TSizes.defaultSpace,
                bottom: TSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  //Rating and Share
                  TRatingAndShare(),

                  //Price, title, brand
                  TProductMetaData(),

                  //Attributes
                  TProductAttributes(),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  //Checkout Button
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {}, child: Text('Checkout'))),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  //Description
                  const TSectionHeading(
                    title: 'Description',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  ReadMoreText(
                    'Check shirt for men is made with Pure 100% Cotton Check Shirts for Men material. This Stylish Checked Shirt for Men gives a comfortable and breathable fit, Sleeve & neck Type: This Mens Formal Check Shirts for Men checks sleeves and Button Down shirt is ideal for all seasons and perfects to wear anywhere',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show More',
                    trimExpandedText: ' Less',
                    moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  //Reviews
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TSectionHeading(title: 'Reviews(199)', showActionButton: false,),
                      IconButton(icon: const Icon(Iconsax.arrow_right_3, size: 18,), onPressed: () => Get.to(() => const ProductReviewScreen()),),
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
