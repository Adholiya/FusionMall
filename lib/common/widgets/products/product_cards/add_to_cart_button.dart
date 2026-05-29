import 'package:ecommerce_shop/features/shop/controllers/product/cart_controller.dart';
import 'package:ecommerce_shop/features/shop/models/product_model.dart';
import 'package:ecommerce_shop/utils/constants/colors.dart';
import 'package:ecommerce_shop/utils/constants/enums.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductCardAddToCartButton extends StatelessWidget {
  const ProductCardAddToCartButton({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return InkWell(
      onTap: () {
        if (product.productType == ProductType.single.toString()) {
          final cartItem = cartController.convertToCartItem(product, 1);
          cartController.addOneToCart(cartItem);
        } else {}
      },
      child: Obx(
        () {
          final productQuantityInCart =
              cartController.getProductQuantityInCart(product.id);
          return Container(
            decoration: BoxDecoration(
                color:
                    productQuantityInCart > 0 ? TColors.primary : TColors.dark,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(TSizes.cardRadiusMd),
                    bottomRight: Radius.circular(TSizes.productImageRadius))),
            child: SizedBox(
                width: TSizes.iconLg * 1.2,
                height: TSizes.iconLg * 1.2,
                child: Center(
                    child: productQuantityInCart > 0
                        ? Text(productQuantityInCart.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .apply(color: TColors.white))
                        : const Icon(
                            Iconsax.add,
                            color: TColors.white,
                          ))),
          );
        },
      ),
    );
  }
}
