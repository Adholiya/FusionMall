import 'package:ecommerce_shop/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_shop/features/personalization/controllers/address_controller.dart';
import 'package:ecommerce_shop/features/personalization/screens/address/add_new_address.dart';
import 'package:ecommerce_shop/features/personalization/screens/address/widgets/single_address.dart';
import 'package:ecommerce_shop/utils/constants/colors.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:ecommerce_shop/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: Icon(
          Iconsax.add,
          color: TColors.white,
        ),
      ),
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
                // Use key to trigger refresh
                key: Key(controller.refreshData.value.toString()),
                future: controller.getAllUserAddresses(),
                builder: (context, snapshot) {
                  // Helper functions, handle loader, no record or error message
                  final response = TCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot);
                  if (response != null) {
                    return response;
                  }
            
                  final addresses = snapshot.data!;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: addresses.length,
                      itemBuilder: (_, index) => TSingleAddress(
                            address: addresses[index],
                            onTap: () => controller.selectAddress(addresses[index]),
                          ));
                }),
          ),
        ),
      ),
    );
  }
}
