import 'package:ecommerce_shop/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_shop/features/shop/screens/checkout/widgets/update_name_controller.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:ecommerce_shop/utils/constants/text_strings.dart';
import 'package:ecommerce_shop/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Change Name',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            Text(
              'Use real name for varification',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            Form(
                key: controller.updateUserNameFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.firstname,
                      validator: (value) =>
                          TValidator.validateEmptyText('First name', value),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: TText.firstName,
                          prefixIcon: Icon(Iconsax.user)),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    TextFormField(
                      controller: controller.lastName,
                      validator: (value) =>
                          TValidator.validateEmptyText('Last name', value),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: TText.firstName,
                          prefixIcon: Icon(Iconsax.user)),
                    ),
                  ],
                )),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            //save btn
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.updateUserName(),
                  child: const Text('Save')),
            )
          ],
        ),
      ),
    );
  }
}
