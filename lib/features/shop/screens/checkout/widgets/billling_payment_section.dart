import 'package:ecommerce_shop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce_shop/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_shop/utils/constants/colors.dart';
import 'package:ecommerce_shop/utils/constants/image_strings.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:ecommerce_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TBillingPaymentSection extends StatelessWidget {
  const TBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        TSectionHeading(title: 'Payment Method', buttonTitle: 'Change', onPressed: () {},),
        const SizedBox(height: TSizes.spaceBtwItems / 2,),
        Row(
          children: [
            TRoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: dark ? TColors.light : TColors.white,
              padding: const EdgeInsets.all(TSizes.sm),
              child: const Image(image: AssetImage(TImages.cashOnDelivery), fit: BoxFit.contain,),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2,),
            Text('Cash On Delivery', style: Theme.of(context).textTheme.bodyLarge,),
          ],
        ),
      ],
    );
  }
}