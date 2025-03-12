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

class EditBannerController extends GetxController{
  static EditBannerController get instance => Get.find();

  final imageUrl = ''.obs;
  final loading = false.obs;
  final isActive = false.obs;
  final targetScreen = ''.obs;
  final formKey = GlobalKey<FormState>();
  final repository = Get.put(BannerRepository());

  // Init Data
  void init (BannerModel banner) {
    imageUrl.value = banner.imageUrl;
    isActive.value = banner.active;
    targetScreen.value = banner.targetScreen;
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
  Future<void> updateBanner(BannerModel banner) async {
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

      // Is Data Updated
     if (banner.imageUrl != imageUrl.value || banner.targetScreen != targetScreen.value || banner.active != isActive.value) {
      // Map Data
      banner.imageUrl = imageUrl.value;
      banner.targetScreen = targetScreen.value;
      banner.active = isActive.value;

      // Call Repository to Update
      await repository.updateBanner(banner);
     }

      // Update all Data list
      BannerController.instance.updateItemFromLists(banner);

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