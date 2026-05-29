import 'package:ecommerce_shop/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_shop/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:ecommerce_shop/features/shop/screens/checkout/checkout.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title: Text(
            'Cart',
            style: Theme.of(context).textTheme.headlineSmall,
          )),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: TCartItems()
      ),

      //Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(onPressed: () => Get.to(() => const CheckoutScreen()), child: Text('Checkout ₹599')),
      ),
    );
  }
}
