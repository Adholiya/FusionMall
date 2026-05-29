import 'package:ecommerce_shop/common/widgets.login_signup/form_divider.dart';
import 'package:ecommerce_shop/common/widgets.login_signup/social_buttons.dart';
import 'package:ecommerce_shop/features/authentication/screens/signup/signup_form.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:ecommerce_shop/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                TText.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Form
              const TSignupForm(),
              const SizedBox(height: TSizes.spaceBtwSections,),

              //Divider
              TFormDivider(dividertext: TText.orSignupWith.capitalize!),
              const SizedBox(height: TSizes.spaceBtwSections,),

              //Social Buttons
              const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
