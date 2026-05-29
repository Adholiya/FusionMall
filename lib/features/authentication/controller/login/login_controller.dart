import 'package:ecommerce_shop/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce_shop/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce_shop/utils/network/loaders.dart';
import 'package:ecommerce_shop/utils/network/network_manager.dart';
import 'package:ecommerce_shop/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController{

  // Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  // Email and password sign in
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start loading
      // TFullScreenLoader.openLoadingDialog('Logging you in....', TImages.staticSuccessIllustrations);

      // Check for internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if(!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save data if remember me is selected
      if(rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login user using emnail and password
      // ignore: unused_local_variable
      final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Google Sign In Authentication
  Future<void> googleSignIn() async {
    try {
      // Start Loading
      // TFullScreenLoader.openLoadingDialog('Logging you in....', TImages.staticSuccessIllustrations);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Google Authentication
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      // Save user record
      await userController.saveUserRecord(userCredentials);

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Redirect 
      AuthenticationRepository.instance.screenRedirect();

    } catch (e) {
      // Remove Loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}