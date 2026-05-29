import 'package:ecommerce_shop/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:ecommerce_shop/utils/constants/colors.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:ecommerce_shop/utils/constants/text_strings.dart';
import 'package:ecommerce_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Heading
            Text(TText.forgetPasswordTitle, style: Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: TSizes.spaceBtwItems,),
            Text(TText.forgetPasswordSubtitle, style: Theme.of(context).textTheme.labelMedium,),
            const SizedBox(height: TSizes.spaceBtwSections * 2,),

            //Text Field
            TextFormField(
              decoration: InputDecoration(
                labelText: TText.email,
                prefixIcon: const Icon(Iconsax.direct_right),
                labelStyle: TextStyle(
                  color: dark ? TColors.white : TColors.black,
                  fontSize: TSizes.fontSizeMd,
                ) 
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections,),

            //Submit Button
            SizedBox( width: double.infinity, child: ElevatedButton(onPressed: () => Get.off(() => const ResetPassword()), child: Text(TText.submit))),
          ],
        ),
      ),
    );
  }
}
