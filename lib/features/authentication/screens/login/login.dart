import 'package:ecommerce_shop/common/styles/spacing_styles.dart';
import 'package:ecommerce_shop/common/widgets.login_signup/form_divider.dart';
import 'package:ecommerce_shop/common/widgets.login_signup/social_buttons.dart';
import 'package:ecommerce_shop/features/authentication/screens/login/widgets/login_form.dart';
import 'package:ecommerce_shop/features/authentication/screens/login/widgets/login_header.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:ecommerce_shop/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              // Logo, Title and Subtitle
              const TloginHeader(),

              //Form
              const TLoginForm(),

              //Divider
              TFormDivider(dividertext: TText.orSignInWith.capitalize!,),
              const SizedBox(height: TSizes.spaceBtwSections,),

              //Footer
              const TSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}

