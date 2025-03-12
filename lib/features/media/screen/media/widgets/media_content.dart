import 'package:danastoreadminpanel/common/widgets/containers/rounded_container.dart';
import 'package:danastoreadminpanel/common/widgets/images/t_rounded_image.dart';
import 'package:danastoreadminpanel/common/widgets/loaders/animation_loader.dart';
import 'package:danastoreadminpanel/common/widgets/loaders/loader_animation.dart';
import 'package:danastoreadminpanel/features/media/controllers/media_controller.dart';
import 'package:danastoreadminpanel/features/media/screen/media/widgets/folder_dropdown.dart';
import 'package:danastoreadminpanel/features/shop/models/image_model.dart';
import 'package:danastoreadminpanel/utils/constants/colors.dart';
import 'package:danastoreadminpanel/utils/constants/enums.dart';
import 'package:danastoreadminpanel/utils/constants/image_strings.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:danastoreadminpanel/view_image_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MediaContent extends StatelessWidget {
  MediaContent({
    super.key,
    required this.allowSelection,
    required this.allowMultipleSelection,
    this.alreadySelectedUrls,
    this.onImagesSelected,
  });

  final bool allowSelection;
  final bool allowMultipleSelection;
  final List<String>? alreadySelectedUrls;
  final List<ImageModel> selectedImages = [];
  final Function(List<ImageModel> selectedImages)? onImagesSelected;

  @override
  Widget build(BuildContext context) {
    bool loadedPreviousSelection = false;
    final controller = MediaController.instance;
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Media Images Header - Now Responsive
          _buildResponsiveHeader(context, controller),

          const SizedBox(height: TSizes.spaceBtwSections),

          /// Show Media
          Obx(
            () {
              // Get Selected Folder Images
              List<ImageModel> images = _getSelectedFolderImages(controller);

              // Load Selected Images from the Already selected Images only once otherwise
              // on Obx() rebuild UI first images will be selected then will auto uncheck.
              if (!loadedPreviousSelection) {
                if (alreadySelectedUrls != null &&
                    alreadySelectedUrls!.isNotEmpty) {
                  // Convert alreadySelectedUrls to a Set for faster lookup
                  final selectedUrlsSet =
                      Set<String>.from(alreadySelectedUrls!);

                  for (var image in images) {
                    image.isSelected.value =
                        selectedUrlsSet.contains(image.url);
                    if (image.isSelected.value) {
                      selectedImages.add(image);
                    }
                  }
                } else {
                  // if already SelectedUrls is null or empty, set all images to not selected
                  for (var image in images) {
                    image.isSelected.value = false;
                  }
                }
                loadedPreviousSelection = true;
              }

              // Loader
              if (controller.loading.value && images.isEmpty) {
                return const TLoaderAnimation();
              }

              // Empty Widget
              if (images.isEmpty) return _buildEmptyAnimationWidget(context);

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    spacing: 8.0, // Add spacing to prevent overlap
                    runSpacing: 8.0, // Add spacing between rows
                    children: images.map((image) {
                      return GestureDetector(
                        onTap: () => Get.dialog(ImagePopup(image: image)),
                        child: SizedBox(
                          width: 140,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              allowSelection
                                  ? _buildListWithCheckbox(image)
                                  : _buildSimpleList(image),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                                child: Text(
                                  image.filename,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 2, // Allows filenames to wrap
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign
                                      .center, // Centers text below the image
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  /// Load More Media Button -> Show when all images loaded
                  if (!controller.loading.value)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: TSizes.spaceBtwSections),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: TSizes.buttonWidth,
                            child: ElevatedButton.icon(
                              onPressed: () => controller.loadMoreMediaImages(),
                              label: const Text('Load More'),
                              icon: const Icon(
                                Iconsax.arrow_down,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // New responsive header method
  Widget _buildResponsiveHeader(BuildContext context, MediaController controller) {
    // Check if screen is mobile sized
    bool isMobile = MediaQuery.of(context).size.width < 600;

    if (isMobile) {
      // Mobile layout - stack elements vertically
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Folder selection row - made full width
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Select Folder',
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: TSizes.xs),
                    MediaFolderDropdown(
                      onChanged: (MediaCategory? newValue) {
                        if (newValue != null) {
                          controller.selectedPath.value = newValue;
                          controller.getMediaImages();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          // Add spacing between rows
          if (allowSelection) const SizedBox(height: TSizes.md),
          
          // Action buttons row - make buttons fill available width
          if (allowSelection) 
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    label: const Text('Close'),
                    icon: const Icon(
                      Iconsax.image,
                      color: Colors.black,
                    ),
                    onPressed: () => Get.back(),
                  ),
                ),
                const SizedBox(width: TSizes.spaceBtwItems),
                Expanded(
                  child: ElevatedButton.icon(
                    label: const Text('Add'),
                    icon: const Icon(
                      Iconsax.image,
                      color: Colors.white,
                    ),
                    onPressed: () => Get.back(result: selectedImages),
                  ),
                ),
              ],
            ),
        ],
      );
    } else {
      // Desktop/tablet layout - original horizontal layout
      return Row(
        children: [
          Row(
            children: [
              Text('Select Folder',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(width: TSizes.spaceBtwItems),
              MediaFolderDropdown(
                onChanged: (MediaCategory? newValue) {
                  if (newValue != null) {
                    controller.selectedPath.value = newValue;
                    controller.getMediaImages();
                  }
                },
              ),
            ],
          ),
          const Spacer(), // Pushes the buttons to the right
          if (allowSelection) buildAndSelectedImagesButton(),
        ],
      );
    }
  }

  List<ImageModel> _getSelectedFolderImages(MediaController controller) {
    List<ImageModel> images = [];
    if (controller.selectedPath.value == MediaCategory.banners) {
      images = controller.allBannerImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.brands) {
      images = controller.allBrandsImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.categories) {
      images = controller.allCategoryImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.products) {
      images = controller.allProductImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.users) {
      images = controller.allUserImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    }
    return images;
  }

  Widget _buildEmptyAnimationWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.lg * 3),
      child: TAnimationLoaderWidget(
        width: 300,
        height: 300,
        text: 'Select your Desired Folder',
        animation: TImages.packageAnimation,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _buildSimpleList(ImageModel image) {
    return TRoundedImage(
      width: 140,
      height: 140,
      padding: TSizes.sm,
      image: image.url,
      imageType: ImageType.network,
      margin: TSizes.spaceBtwItems / 2,
      backgroundColor: TColors.primaryBackground,
    );
  }

  Widget _buildListWithCheckbox(ImageModel image) {
    return Stack(
      children: [
        TRoundedImage(
          width: 140,
          height: 140,
          padding: TSizes.sm,
          image: image.url,
          imageType: ImageType.network,
          margin: TSizes.spaceBtwItems,
          backgroundColor: TColors.primaryBackground,
        ),
        Positioned(
          top: TSizes.md,
          right: TSizes.md,
          child: Obx(() => Checkbox(
              value: image.isSelected.value,
              onChanged: (selected) {
                if (selected != null) {
                  image.isSelected.value = selected;

                  if (selected) {
                    if (!allowMultipleSelection) {
                      // If multiple selection is not allowed, uncheck other checkboxes
                      for (var otherImage in selectedImages) {
                        if (otherImage != image) {
                          otherImage.isSelected.value = false;
                        }
                      }
                      selectedImages.clear();
                    }

                    selectedImages.add(image);
                  } else {
                    selectedImages.remove(image);
                  }
                }
              })),
        )
      ],
    );
  }

  Widget buildAndSelectedImagesButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Close Button
        SizedBox(
          width: 120,
          child: OutlinedButton.icon(
              label: const Text('Close'),
              icon: const Icon(
                Iconsax.image,
                color: Colors.black,
              ),
              onPressed: () => Get.back()),
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        SizedBox(
          width: 120,
          child: ElevatedButton.icon(
            label: const Text('Add'),
            icon: const Icon(
              Iconsax.image,
              color: Colors.white,
            ),
            onPressed: () => Get.back(result: selectedImages),
          ),
        )
      ],
    );
  }
}