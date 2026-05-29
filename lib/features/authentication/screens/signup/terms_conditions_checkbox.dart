import 'package:ecommerce_shop/features/authentication/controller/signup/signup_controller.dart';
import 'package:ecommerce_shop/utils/constants/colors.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:ecommerce_shop/utils/constants/text_strings.dart';
import 'package:ecommerce_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TTermsAndConditionCheckbox extends StatelessWidget {
  const TTermsAndConditionCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final bool dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
            width: 16,
            height: 24,
            child: Obx(() => Checkbox(
                value: controller.privacyPolicy.value,
                onChanged: (value) => controller.privacyPolicy.value =
                    !controller.privacyPolicy.value))),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: '${TText.iAgreeTo} ',
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: '${TText.privacyPolicy} ',
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? TColors.white : TColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? TColors.white : TColors.primary,
                  )),
          TextSpan(
              text: '${TText.and} ',
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: '${TText.termsOfUse} ',
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? TColors.white : TColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? TColors.white : TColors.primary,
                  )),
        ])),
      ],
    );
  }
}
