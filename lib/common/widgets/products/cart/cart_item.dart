import 'package:ecommerce_shop/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce_shop/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce_shop/common/widgets/texts/t_brand_title_with_verified_icon.dart';
import 'package:ecommerce_shop/utils/constants/colors.dart';
import 'package:ecommerce_shop/utils/constants/image_strings.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:ecommerce_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //Image
        TRoundedImage(
          imageUrl: TImages.productIamge1,
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor: THelperFunctions.isDarkMode(context)
              ? TColors.darkerGrey
              : TColors.light,
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
    
        //Title, Price and Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBrandTitleWithVerifiedIcon(title: 'Nike'),
              Flexible(
                child: TProductTitleText(
                  title: 'Shoes for Men',
                  maxLines: 1,
                ),
              ),
              //Attributes
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Color ', style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(text: 'Black ', style: Theme.of(context).textTheme.bodyLarge),
                    TextSpan(text: 'Size ', style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(text: '38 ', style: Theme.of(context).textTheme.bodyLarge),
                  ]
                )
              )
            ],
          ),
        ),
      ],
    );
  }
}
