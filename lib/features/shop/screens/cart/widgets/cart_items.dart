import 'package:ecommerce_shop/common/widgets/products/cart/add_remove_button.dart';
import 'package:ecommerce_shop/common/widgets/products/cart/cart_item.dart';
import 'package:ecommerce_shop/common/widgets/products/price/product_price_text.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 1,
      separatorBuilder: (_, __) => const SizedBox(
        height: TSizes.spaceBtwSections,
      ),
      itemBuilder: (_, index) => Column(
        children: [
          //Cart Item
          TCartItem(),
          if(showAddRemoveButtons) const SizedBox(height: TSizes.spaceBtwItems),

          //Add Remove Button Row with total Price
          if(showAddRemoveButtons) 
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  //Extra Space
                  SizedBox(width: 70),
                  //Add Remove Buttons
                  TProductQuantityWithAddRemoveButton(),
                ],
              ),

              //Product Total Price
              TProductPriceText(price: '599'),
            ],
          ),
        ],
      ),
    );
  }
}
