import 'package:ecommerce_shop/utils/constants/image_strings.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:ecommerce_shop/utils/constants/text_strings.dart';
import 'package:ecommerce_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TloginHeader extends StatelessWidget {
  const TloginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 150,
          image: AssetImage(
              dark ? TImages.lightAppLogo : TImages.darkAppLogo),
        ),
        Text(
          TText.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: TSizes.sm),
        Text(
          TText.loginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
