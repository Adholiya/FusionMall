import 'package:ecommerce_shop/common/widgets/chips/choice_chip.dart';
import 'package:ecommerce_shop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce_shop/common/widgets/products/price/product_price_text.dart';
import 'package:ecommerce_shop/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce_shop/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_shop/utils/constants/colors.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:ecommerce_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        //Selected Attribute Price and Description
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.darkGrey : TColors.grey,
          child: Column(
            children: [
              //Title, Price and Stock Status
              Row(
                children: [
                  TSectionHeading(title: 'Variation', showActionButton: false),
                  const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const TProductTitleText(
                            title: 'Price : ',
                            smallSize: true,
                          ),
                          //Actual Price
                          Text(
                            '₹25',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),
                          //Sale Price
                          const TProductPriceText(price: '20'),
                        ],
                      ),
                      Row(
                        children: [
                          const TProductTitleText(
                            title: 'Stock : ',
                            smallSize: true,
                          ),
                          Text(
                            'In Stock',
                            style: Theme.of(context).textTheme.titleMedium,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
              //Variation Description
              TProductTitleText(
                //This is the Description of the Product and it can go up to Max 4 Lines.
                title:
                    'This is the Description of the Product and it can go up to Max 4 Lines.',
                smallSize: true,
                maxLines: 4,
              )
            ],
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        //Attributes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'Colors', showActionButton: false,),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(text: 'Green', selected: true, onSelected: (value) {},),
                TChoiceChip(text: 'Blue', selected: false, onSelected: (value) {},),
                TChoiceChip(text: 'Yellow', selected: false, onSelected: (value) {},),
              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TSectionHeading(title: 'Size', showActionButton: false),
            SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(text: 'XL', selected: true, onSelected: (value) {},),
                TChoiceChip(text: '2XL', selected: false, onSelected: (value) {},),
                TChoiceChip(text: '3XL', selected: false, onSelected: (value) {},)
              ],
            ),
          ],
        ),
      ],
    );
  }
}

