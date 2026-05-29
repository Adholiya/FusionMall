import 'package:ecommerce_shop/common/widgets/brand/brand_show_case.dart';
import 'package:ecommerce_shop/features/shop/controllers/brand_controller.dart';
import 'package:ecommerce_shop/features/shop/models/category_model.dart';
import 'package:ecommerce_shop/utils/constants/boxes_shimmer.dart';
import 'package:ecommerce_shop/utils/constants/image_strings.dart';
import 'package:ecommerce_shop/utils/constants/list_tile_shimmer.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
        future: controller.getBrandsForCategory(category.id),
        builder: (context, snapshot) {
          // Handle loader or no data or error
          // ignore: unused_local_variable
          const loader = Column(
            children: [
              TListTileShimmer(),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TBoxesShimmer(),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
            ],
          );
          if (category.name == 'Sports') {
            return TBrandShowcase(images: [
              TImages.productIamge1,
              TImages.productIamge2,
              TImages.productIamge3,
            ]);
          } else if (category.name == 'Clothes') {
            return TBrandShowcase(images: [
              TImages.productIamge4,
              TImages.productIamge5,
              TImages.productIamge6,
            ]);
          } else if (category.name == 'Electronics') {
            return TBrandShowcase(images: [
              TImages.productIamge7,
              TImages.productIamge8,
              TImages.productIamge9,
            ]);
          } else if (category.name == 'Furniture') {
            return TBrandShowcase(images: [
              TImages.productIamge10,
              TImages.productIamge11,
              TImages.productIamge12,
            ]);
          } else if (category.name == 'Kitchen') {
            return TBrandShowcase(images: [
              TImages.productIamge13,
              TImages.productIamge14,
              TImages.productIamge15,
            ]);
          } else {
            return const TBrandShowcase(images: [
              TImages.productIamge1,
            ]);
          }
        });
  }
}
