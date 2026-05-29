import 'package:ecommerce_shop/data/repositories/address/address_repository.dart';
import 'package:ecommerce_shop/features/shop/models/address_model.dart';
import 'package:ecommerce_shop/utils/network/loaders.dart';
import 'package:ecommerce_shop/utils/network/network_manager.dart';
import 'package:ecommerce_shop/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  // Fetch all user specific addresses
  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere((element) => element.selectedAddress, orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Address not found', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {

      // Clear the "SELECTED" field
      if(selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(selectedAddress.value.id, false);
      }

      // Assign "SELECTED" address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      // Set the "SELECTED" field to true for the newlyt selected address
      await addressRepository.updateSelectedField(selectedAddress.value.id, true);

    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error in selection', message: e.toString());
    }
  }

  // Add New Address
  Future addNewAddress() async {
    try {
      // Start Loading
      // TFullScreenLoader.openLoadingDialog('Storing Address', TImages.staticSuccessIllustrations);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if(!addressFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save address data
      final address = AddressModel(name: name.text.trim(), phoneNumber: phoneNumber.text.trim(), street: street.text.trim(), city: city.text.trim(), state: state.text.trim(), postalCode: postalCode.text.trim(), country: country.text.trim(), id: '', selectedAddress: true,);
      final id = await addressRepository.addAddress(address);

      // Update selected address
      address.id = id;
      await selectAddress(address);

      // remove loader
      TFullScreenLoader.stopLoading();

      // Show success message
      TLoaders.successSnackBar(title: 'Congratulations', message: 'Your address have been saved successfully');

      // Refresh address data
      refreshData.toggle();

      // Reset fields
      resetFormFields();

      // Redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      // Remove Loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Address Not found', message: e.toString());
    }
  }

  // Function to reset form fields
  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}
