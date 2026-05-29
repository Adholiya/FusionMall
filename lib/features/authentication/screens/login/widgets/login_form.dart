import 'package:ecommerce_shop/features/authentication/controller/login/login_controller.dart';
import 'package:ecommerce_shop/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:ecommerce_shop/features/authentication/screens/signup/signup.dart';
import 'package:ecommerce_shop/utils/constants/colors.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:ecommerce_shop/utils/constants/text_strings.dart';
import 'package:ecommerce_shop/utils/helpers/helper_functions.dart';
import 'package:ecommerce_shop/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(LoginController());
    final dark = THelperFunctions.isDarkMode(context);
    
    return Form(
        key: controller.loginFormKey,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
          child: Column(
            children: [
              //Email
              TextFormField(
                controller: controller.email,
                validator: (value) => TValidator.validateEmail(value),
                decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: TText.email,
                    labelStyle: TextStyle(
                      color: dark ? TColors.white : TColors.black,
                      fontSize: TSizes.fontSizeMd,
                    )),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),

              //Password
              Obx(
                () => TextFormField(
                  controller: controller.password,
                  validator: (value) => TValidator.validatePassword(value),
                  obscureText: controller.hidePassword.value,
                  decoration: InputDecoration(
                      labelText: TText.password,
                      prefixIcon: Icon(Iconsax.password_check),
                      suffixIcon: IconButton(
                          onPressed: () => controller.hidePassword.value =
                              !controller.hidePassword.value,
                          icon: Icon(controller.hidePassword.value
                              ? Iconsax.eye_slash
                              : Iconsax.eye)),
                      labelStyle: TextStyle(
                          color: dark ? TColors.white : TColors.black,
                          fontSize: TSizes.fontSizeMd)),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields / 2,
              ),

              //Remember Me and Forget Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Remember Me
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                            value: controller.rememberMe.value,
                            onChanged: (value) => controller.rememberMe.value = !controller.rememberMe.value),
                      ),
                      const Text(TText.rememberMe),
                    ],
                  ),

                  //Forget Password
                  TextButton(
                      onPressed: () => Get.to(() => const ForgetPassword()),
                      child: const Text(TText.forgetPassword))
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //Sign In Button
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.emailAndPasswordSignIn(),
                      child: Text(TText.signIn))),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              //Create Account Button
              SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () => Get.to(() => const SignUpScreen()),
                      child: Text(TText.creteAccount))),
            ],
          ),
        ));
  }
}
