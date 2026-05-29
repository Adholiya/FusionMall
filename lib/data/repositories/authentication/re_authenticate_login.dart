import 'package:ecommerce_shop/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:ecommerce_shop/utils/constants/text_strings.dart';
import 'package:ecommerce_shop/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthenticateLogin extends StatelessWidget {
  // ignore: use_super_parameters
  const ReAuthenticateLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Re-authenticate user'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
              key: controller.reAuthFormkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //email
                  TextFormField(
                    controller: controller.verifyEmail,
                    validator: TValidator.validateEmail,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.direct_right),
                        labelText: TText.email),
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),

                  //password
                  Obx(() => TextFormField(
                        obscureText: controller.hidePassword.value,
                        controller: controller.verifyPassword,
                        // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                        validator: (Value) =>
                            TValidator.validateEmptyText(' Password', Value),
                        decoration: InputDecoration(
                            labelText: TText.password,
                            prefixIcon: const Icon(Iconsax.password_check),
                            suffixIcon: IconButton(
                                onPressed: () => controller.hidePassword.value =
                                    !controller.hidePassword.value,
                                icon: const Icon(Iconsax.eye_slash))),
                      )),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  //login btn
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () =>
                            controller.reAuthenticateEmailAndPassword(),
                        child: const Text('Verify')),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
