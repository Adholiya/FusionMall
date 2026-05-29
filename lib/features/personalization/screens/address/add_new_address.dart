import 'package:ecommerce_shop/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_shop/features/personalization/controllers/address_controller.dart';
import 'package:ecommerce_shop/utils/constants/colors.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:ecommerce_shop/utils/helpers/helper_functions.dart';
import 'package:ecommerce_shop/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = AddressController.instance;

    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Add new Addess'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: [
                TextFormField(
                    controller: controller.name,
                    validator: (value) => TValidator.validateEmptyText('Name', value),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.user),
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          color: dark ? TColors.white : TColors.black,
                          fontSize: TSizes.fontSizeMd,
                        ))),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                TextFormField(
                    controller: controller.phoneNumber,
                    validator: TValidator.validatePhoneNumber,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.mobile),
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(
                          color: dark ? TColors.white : TColors.black,
                          fontSize: TSizes.fontSizeMd,
                        ))),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          controller: controller.street,
                          validator: (value) => TValidator.validateEmptyText('Street', value),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Iconsax.building_31),
                              labelText: 'Street',
                              labelStyle: TextStyle(
                                color: dark ? TColors.white : TColors.black,
                                fontSize: TSizes.fontSizeMd,
                              ))),
                    ),
                    const SizedBox(
                      width: TSizes.spaceBtwInputFields,
                    ),
                    Expanded(
                      child: TextFormField(
                          controller: controller.postalCode,
                          validator: (value) => TValidator.validateEmptyText('PostalCode', value),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Iconsax.code),
                              labelText: 'Postal Code',
                              labelStyle: TextStyle(
                                color: dark ? TColors.white : TColors.black,
                                fontSize: TSizes.fontSizeMd,
                              ))),
                    ),
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          controller: controller.city,
                          validator: (value) => TValidator.validateEmptyText('City', value),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Iconsax.building),
                              labelText: 'City',
                              labelStyle: TextStyle(
                                color: dark ? TColors.white : TColors.black,
                                fontSize: TSizes.fontSizeMd,
                              ))),
                    ),
                    const SizedBox(
                      width: TSizes.spaceBtwInputFields,
                    ),
                    Expanded(
                      child: TextFormField(
                          controller: controller.state,
                          validator: (value) => TValidator.validateEmptyText('State', value),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Iconsax.activity),
                              labelText: 'State',
                              labelStyle: TextStyle(
                                color: dark ? TColors.white : TColors.black,
                                fontSize: TSizes.fontSizeMd,
                              ))),
                    ),
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                TextFormField(
                    controller: controller.country,
                    validator: (value) => TValidator.validateEmptyText('Country', value),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.global),
                        labelText: 'Country',
                        labelStyle: TextStyle(
                          color: dark ? TColors.white : TColors.black,
                          fontSize: TSizes.fontSizeMd,
                        ))),
                const SizedBox(
                  height: TSizes.defaultSpace,
                ),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => controller.addNewAddress(), child: Text('Save')),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
