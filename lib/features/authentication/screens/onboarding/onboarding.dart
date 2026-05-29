import 'package:ecommerce_shop/features/authentication/controllers.onboarding/onboarding_controller.dart';
import 'package:ecommerce_shop/features/authentication/screens/widgets/onboarding_dot_navigation.dart';
import 'package:ecommerce_shop/features/authentication/screens/widgets/onboarding_next_button.dart';
import 'package:ecommerce_shop/features/authentication/screens/widgets/onboarding_page.dart';
import 'package:ecommerce_shop/features/authentication/screens/widgets/onboarding_skip.dart';
import 'package:ecommerce_shop/utils/constants/image_strings.dart';
import 'package:ecommerce_shop/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              // Horizontal Scrollable Pages
              OnBoardingPage(
                image: TImages.onBoardingImage1,
                title: TText.onBoardingTitle1,
                subTitle: TText.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage2,
                title: TText.onBoardingTitle2,
                subTitle: TText.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage3,
                title: TText.onBoardingTitle3,
                subTitle: TText.onBoardingSubTitle3,
              ),
            ],
          ),
          // Skip Button
          const OnBoardingSkip(),
          // Dot Navigation SmoothPageIndicator
          const OnBoardingDotNavigation(),

          // Circular Button
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}


