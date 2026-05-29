import 'package:ecommerce_shop/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_shop/common/widgets/images/t_circular_image.dart';
import 'package:ecommerce_shop/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_shop/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce_shop/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:ecommerce_shop/features/shop/screens/checkout/change_name.dart';
import 'package:ecommerce_shop/utils/constants/image_strings.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title:
            Text('Profile', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const TCircularImage(image: TImages.userProfileImage1, width: 80, height: 80,),
                    TextButton(onPressed: () {}, child: const Text('Change Profile Picture'))
                  ],
                ),
              ),

              //Heading Profile
              const SizedBox(height: TSizes.spaceBtwItems / 2,),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems,),
              TSectionHeading(title: 'Profile Information', showActionButton: false,),
              const SizedBox(height: TSizes.spaceBtwItems,),

              TProfileMenu(onPressed: () => Get.to(() => const ChangeName()), title: 'Name', value: controller.user.value.fullName),
              TProfileMenu(onPressed: () {}, title: 'Username', value: controller.user.value.username),

              const SizedBox(height: TSizes.spaceBtwItems,),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems,),

              //Heading Information
              const TSectionHeading(title: 'Personal Information', showActionButton: false,),
              const SizedBox(height: TSizes.spaceBtwItems,),

              TProfileMenu(onPressed: () {}, title: 'User ID', icon: Iconsax.copy, value: controller.user.value.id),
              TProfileMenu(onPressed: () {}, title: 'E-mail', value: controller.user.value.email),
              TProfileMenu(onPressed: () {}, title: 'Phone Number', value: controller.user.value.phoneNumber),
              TProfileMenu(onPressed: () {}, title: 'Gender', value: 'Male'),
              TProfileMenu(onPressed: () {}, title: 'Date Of Birth', value: '4 Dec, 2003'),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems,),

              Center(
                child: TextButton(onPressed: () => controller.deleteAccountWaringPopup(), child: const Text('Close Account', style: TextStyle(color: Colors.red),)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
