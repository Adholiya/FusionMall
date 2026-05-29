import 'package:ecommerce_shop/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_shop/common/widgets/icon/t_circular_icon.dart';
import 'package:ecommerce_shop/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce_shop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:ecommerce_shop/features/shop/models/product_model.dart';
import 'package:ecommerce_shop/features/shop/screens/home/home.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TCircularIcon(
              icon: Iconsax.add, onPressed: () => Get.to(const HomeScreen()))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TGridLayout(itemCount: 6, itemBuilder: (_,index) => TProductCardVertical(product: ProductModel.empty(),))
            ],
          ),
        ),
      ),
    );
  }
}
