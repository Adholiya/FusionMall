import 'package:ecommerce_shop/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_shop/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce_shop/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:ecommerce_shop/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:ecommerce_shop/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_shop/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce_shop/features/personalization/screens/address/address.dart';
import 'package:ecommerce_shop/features/personalization/screens/profile/profile.dart';
import 'package:ecommerce_shop/features/shop/screens/contact_us/support_page.dart';
import 'package:ecommerce_shop/features/shop/screens/order/order.dart';
import 'package:ecommerce_shop/utils/constants/colors.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Header
            TPrimaryHeaderContainer(
                child: Column(
              children: [
                //App bar
                TAppBar(
                    title: Text('Account',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .apply(color: TColors.white))),

                //Profile Card
                TUserProfileTile(
                    onPressed: () => Get.to(() => const ProfileScreen())),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                )
              ],
            )),

            //Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  //Account Setting Title
                  TSectionHeading(
                    title: 'Account Settings',
                    showActionButton: false,
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  TSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subTitle: 'Set Shopping Delivery Address',
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subTitle: 'Add, Remove Products and Move to Checkout',
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subTitle: 'In-Progress and Completed Orders',
                    onTap: () => Get.to(() => const OrderScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.bank,
                    title: 'Bank Account',
                    subTitle: 'Withdarw Balance to Registered Bank Account',
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.discount_shape,
                    title: 'My Coupon',
                    subTitle: 'List of all the Discounted Coupons',
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    subTitle: 'Set any Kind of Notification Message',
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy',
                    subTitle: 'Manage Data Usage and Connected Accounts',
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.message,
                    title: 'Contact Us',
                    subTitle: 'Contact Us for any Queries or Difficulties',
                    onTap: () => Get.to(() => SupportPage()), 
                  ),

                  //App Settings
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  TSectionHeading(
                    title: 'App Settings',
                    showActionButton: false,
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  TSettingsMenuTile(
                      icon: Iconsax.document_upload,
                      title: 'Load Data',
                      subTitle: 'Upload Data to Your Cloud Interface'),
                  TSettingsMenuTile(
                      icon: Iconsax.location,
                      title: 'Geolocation',
                      subTitle: 'Set Recommendation Based on Location',
                      trailing: Switch(value: true, onChanged: (value) {})),
                  TSettingsMenuTile(
                      icon: Iconsax.security_user,
                      title: 'Safe Mode',
                      subTitle: 'Search Result in Safe for all Ages',
                      trailing: Switch(value: false, onChanged: (value) {})),
                  TSettingsMenuTile(
                      icon: Iconsax.image,
                      title: 'HD Image Quality',
                      subTitle: 'Set Image Quality to be Seen',
                      trailing: Switch(value: false, onChanged: (value) {})),

                  //Logout Button
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () async {
                          await AuthenticationRepository.instance.logout();
                        },
                        child: const Text('Logout')),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections * 2.5,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
