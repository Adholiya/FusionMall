import 'package:ecommerce_shop/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce_shop/data/repositories/user/user_repository.dart';
import 'package:ecommerce_shop/features/authentication/screens/signup/verify_email.dart';
import 'package:ecommerce_shop/utils/network/loaders.dart';
import 'package:ecommerce_shop/utils/network/network_manager.dart';
import 'package:ecommerce_shop/utils/usermodel/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Variables
  final hidePassword = true.obs; // used for showing and hiding password
  final privacyPolicy = true.obs; // observable for privacy policy acceptance
  final email = TextEditingController(); // Controller for Email input
  final lastName = TextEditingController(); // Controller for lastname input
  final username = TextEditingController(); // Controller for usernanme input
  final password = TextEditingController(); // Controller for password input
  final firstName = TextEditingController(); // Controller for firstname input
  final phoneNumber =
      TextEditingController(); // Controller for phone number input
  GlobalKey<FormState> signupFormKey =
      GlobalKey<FormState>(); // Form key for form Validation

  // SIGNUP
  void signup() async {
    try {
      // Start loading
      // TFullScreenLoader.openLoadingDialog(
      //     'We are processing your information....', TImages.onBoardingImage1);

      // Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      // Form Validation
      if (!signupFormKey.currentState!.validate()) return;

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use');
        return;
      }

      // Register User in Firebase Authentication & Save User Data in the Firebase
      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(
          email.text.trim(), password.text.trim());

      // Save Authenticated User Data in the Firebase Firestore
      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          username: username.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '');

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Show Success Message
      TLoaders.successSnackBar(title: 'Congratulations', message: 'Your account has been created! Verify email to continue');

      // Move to Verify Email Screen
      Get.to(() => VerifyEmailScreen(email: email.text.toString()));
    } catch (e) {
      // Show some generic error to user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } 
  }
}
