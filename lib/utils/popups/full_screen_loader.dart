import 'package:ecommerce_shop/common/widgets/loaders/animation_loader.dart';
import 'package:ecommerce_shop/utils/constants/colors.dart';
import 'package:ecommerce_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TFullScreenLoader {
  // Open a full screen loading dialog with a given text and animation
  // This method doesnt return anythiing

  // Parameters
    // text: text is to be displayed in loading analog
    // animation: lottle animation is to be shown

  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: THelperFunctions.isDarkMode(Get.context!) ? TColors.dark : TColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 250),
              TAnimationLoaderWidget(text: text, animation: animation),
            ],
          ),
        ),
      )
    );
  }

  // Stop currently open loading dialog
  // This method doesnt return anything
  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();  // Close the dialog using navigator
  }
}