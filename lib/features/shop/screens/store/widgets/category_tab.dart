import 'package:ecommerce_shop/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce_shop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:ecommerce_shop/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_shop/features/shop/controllers/product_controller.dart';
import 'package:ecommerce_shop/features/shop/models/category_model.dart';
import 'package:ecommerce_shop/features/shop/screens/store/widgets/category_brands.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final ProductController _productController = Get.find();
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
                padding: EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                children: [
                    //Brands
                    CategoryBrands(category: category),
                    const SizedBox(height: TSizes.spaceBtwItems,),
                    //Products
                    TSectionHeading(title: 'You Might Like This', onPressed: () {},),
                    const SizedBox(height: TSizes.spaceBtwItems,),
      
                    TGridLayout(itemCount: _productController.featuredProducts.length, itemBuilder: (_,index) => TProductCardVertical(product: _productController.featuredProducts[index],)),
                    const SizedBox(height: TSizes.spaceBtwSections,),
                ],
        ),
      ),
      ],
    );
  }
}