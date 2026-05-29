import 'package:ecommerce_shop/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_shop/common/widgets/brand/brand_card.dart';
import 'package:ecommerce_shop/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce_shop/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_shop/features/shop/controllers/brand_controller.dart';
import 'package:ecommerce_shop/utils/constants/brand_shimmer.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text('Brand'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //Heading
              TSectionHeading(
                title: 'Brands',
                showActionButton: false,
              ),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              //Brands
              Obx(() {
                if (brandController.isLoading.value) {
                  return const TBrandsShimmer();
                }

                if (brandController.allBrands.isEmpty) {
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
                    itemCount: brandController.allBrands.length,
                    mainAxisExtent: 80,
                    itemBuilder: (_, index) {
                      final brand = brandController.allBrands[index];
                      return TBrandCard(brand: brand, showBorder: true);
                    });
              })
            ],
          ),
        ),
      ),
    );
  }
}
