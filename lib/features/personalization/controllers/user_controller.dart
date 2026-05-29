import 'package:ecommerce_shop/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce_shop/data/repositories/authentication/re_authenticate_login.dart';
import 'package:ecommerce_shop/data/repositories/user/user_repository.dart';
import 'package:ecommerce_shop/features/authentication/screens/login/login.dart';
import 'package:ecommerce_shop/utils/constants/image_strings.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:ecommerce_shop/utils/network/loaders.dart';
import 'package:ecommerce_shop/utils/network/network_manager.dart';
import 'package:ecommerce_shop/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_shop/utils/usermodel/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  Rx<UserModel> user = UserModel.empty().obs;
  final profileLoading = false.obs;
  final userRepository = Get.put(UserRepository());

  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormkey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  /// Fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Save user record from any Registration Provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if (userCredentials != null) {
        // Convert name to First and Last name
        final nameParts =
            UserModel.nameParts(userCredentials.user!.displayName ?? '');
        final username =
            UserModel.generateUsername(userCredentials.user!.displayName ?? '');

        // Map the data
        final user = UserModel(
            id: userCredentials.user!.uid,
            username: username,
            email: userCredentials.user!.email ?? '',
            firstName: nameParts[0],
            lastName:
                nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '');

        // Save user data
        await userRepository.saveUserRecord(user);
      }
    } catch (e) {
      TLoaders.warningSnackBar(
        title: 'Data Not Saved',
        message:
            'Something went wrong while saving your information. You can re-save your data in your profile',
      );
    }
  }

  // Delete account warning
  void deleteAccountWaringPopup() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(TSizes.md),
        title: 'Delete Accout',
        middleText: 'Do you want to delete your account permanently?',
        confirm: ElevatedButton(
            onPressed: () async => deleteUserAccount(),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                side: const BorderSide(color: Colors.red)),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
              child: Text('Delete'),
            )),
        cancel: OutlinedButton(
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: const Text('Cancel')));
  }

  
  void deleteUserAccount() async {
    try {
      // TFullScreenLoader.openLoadingDialog('Processing', TImages.staticSuccessIllustrations);
      //frist re authenticate
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          TFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthenticateLogin());
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'oopps!!', message: e.toString());
    }
  }

  Future<void> reAuthenticateEmailAndPassword() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Processing', TImages.staticSuccessIllustrations);

      //check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (!reAuthFormkey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      TFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'Oppss!!', message: e.toString());
    }
  }
}
