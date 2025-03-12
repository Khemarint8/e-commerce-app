import 'package:danastoreadminpanel/app_screen.dart';
import 'package:danastoreadminpanel/features/media/controllers/media_controller.dart';
import 'package:danastoreadminpanel/features/shop/controllers/banner/banner_controller.dart';
import 'package:danastoreadminpanel/features/shop/models/banner_model.dart';
import 'package:danastoreadminpanel/features/shop/repository/banner_repository.dart';
import 'package:danastoreadminpanel/features/shop/models/image_model.dart';
import 'package:danastoreadminpanel/utils/constants/helpers/network_manager.dart';
import 'package:danastoreadminpanel/utils/constants/popups/full_screen_loader.dart';
import 'package:danastoreadminpanel/utils/constants/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CreateBannerController extends GetxController{
  static CreateBannerController get instance => Get.find();

  final imageUrl = ''.obs;
  final loading = false.obs;
  final isActive = false.obs;
  final RxString targetScreen = AppScreen.allAppScreenItems[0].obs;
  final formKey = GlobalKey<FormState>();


  // Method to reset fields  
  void resetFields() {
    loading(false);
    isActive(false);
    imageUrl.value = '';
    targetScreen.value = AppScreen.allAppScreenItems[0];
  }

  // Pick Thumbnail Image from Media 
  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    // Handle the selected Images
    if(selectedImages != null && selectedImages.isNotEmpty) {
      // Set the selected image to the main image or perform any other action
      ImageModel selectedImage = selectedImages.first;
      // Update the main image using the selectedImage
      imageUrl.value = selectedImage.url;
    }
  }

  // Register new Banner 
  Future<void> createBanner() async {
    try{
      // Start loading
      TFullScreenLoader.popUpCircular();

      // Check Internet Connectivity 
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!formKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Map Data
      final newRecord = BannerModel(id: '', targetScreen: targetScreen.value, active: isActive.value,imageUrl: imageUrl.value);

      // Call Repository to Create New Banner and Update Id
      newRecord.id = await BannerRepository.instance.createBanner(newRecord);

      // Update all Data list
      BannerController.instance.addItemToLists(newRecord);

       // Reset Form
      resetFields();

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Success Message & Redirect
      TLoaders.successSnackBar(title: 'Congratulation', message: 'New Record has been added.');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}