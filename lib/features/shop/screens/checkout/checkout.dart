import 'package:ecommerce_shop/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_shop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce_shop/common/widgets/products/cart/coupon_widget.dart';
import 'package:ecommerce_shop/common/widgets/success_screen/success_screen.dart';
import 'package:ecommerce_shop/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:ecommerce_shop/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:ecommerce_shop/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:ecommerce_shop/features/shop/screens/checkout/widgets/billling_payment_section.dart';
import 'package:ecommerce_shop/navigation_menu.dart';
import 'package:ecommerce_shop/utils/constants/colors.dart';
import 'package:ecommerce_shop/utils/constants/image_strings.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:ecommerce_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title: Text(
            'Order Review',
            style: Theme.of(context).textTheme.headlineSmall,
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //Items in Cart
              const TCartItems(
                showAddRemoveButtons: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //Coupon Textfield
              TCouponCode(),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //Billing Section
              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: dark ? TColors.black : TColors.white,
                child: Column(
                  children: [
                    //Pricing
                    TBillingAmountSection(),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),

                    //Divider
                    const Divider(),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),

                    //Payment Methods
                    TBillingPaymentSection(),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),

                    //Address
                    TBillingAddressSection(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),

      //Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: () => Get.to(() => SuccessScreen(image: TImages.orderComplete, title: 'Payment Success', subTitle: 'Your Item will be Shipped Soon', onPressed: () => Get.offAll(() => const NavigationMenu()))),
            child: Text('Checkout ₹599')),
      ),
    );
  }
}
