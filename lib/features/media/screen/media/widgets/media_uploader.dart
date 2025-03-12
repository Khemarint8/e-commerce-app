import 'dart:typed_data';

import 'package:danastoreadminpanel/common/widgets/containers/rounded_container.dart';
import 'package:danastoreadminpanel/common/widgets/images/t_rounded_image.dart';
import 'package:danastoreadminpanel/features/media/controllers/media_controller.dart';
import 'package:danastoreadminpanel/features/media/screen/media/widgets/folder_dropdown.dart';
import 'package:danastoreadminpanel/features/shop/models/image_model.dart';
import 'package:danastoreadminpanel/utils/constants/colors.dart';
import 'package:danastoreadminpanel/utils/constants/device/device_utility.dart';
import 'package:danastoreadminpanel/utils/constants/enums.dart';
import 'package:danastoreadminpanel/utils/constants/image_strings.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;

class MediaUploader extends StatelessWidget {
  const MediaUploader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return Obx(
      () => controller.showImagesUploaderSection.value
          ? Column(
              children: [
                /// Drag and Drop Area
                TRoundedContainer(
                  height: 250,
                  showBorder: true,
                  borderColor: TColors.borderPrimary,
                  backgroundColor: TColors.primaryBackground,
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: Column(
                    children: [
                      Expanded(
                          child: Stack(
                        alignment: Alignment.center,
                        children: [
                          DropzoneView(
                            mime: const ['image/jpeg', 'image/png'],
                            cursor: CursorType.Default,
                            operation: DragOperation.copy,
                            onLoaded: () => print('Zone loaded'),
                            onError: (ev) => print('Zone error: $ev'),
                            onHover: () => print('Zone hovered'),
                            onLeave: () => print('Zone left'),
                            onCreated: (ctrl) =>
                                controller.dropzoneController = ctrl,
                            onDropInvalid: (ev) =>
                                print('Zone invalid MIME: $ev'),
                            onDropMultiple: (ev) =>
                                print('Zone drop multiple: $ev'),
                            onDrop: (file) async {
                              if (file is DropzoneFileInterface) {
                                // Handle DropzoneFileInterface
                                final bytes = await controller
                                    .dropzoneController
                                    .getFileData(file);
                                final filename = await controller
                                    .dropzoneController
                                    .getFilename(file);

                                final image = ImageModel(
                                  url: '',
                                  file: file,
                                  folder: '',
                                  filename: filename,
                                  localImageToDisplay:
                                      Uint8List.fromList(bytes),
                                );
                                controller.selectedImagesToUpload.add(image);
                              } else if (file is html.File) {
                                // Handle native file (e.g. dragged from system)
                                final reader = html.FileReader();
                                reader.readAsArrayBuffer(file);

                                // Wait until the reader has finished reading
                                await reader.onLoadEnd.first;

                                // Convert the array buffer to Uint8List
                                final bytes = reader.result as Uint8List;
                                final filename = file.name;

                                final image = ImageModel(
                                  url: '',
                                  file:
                                      null, // Null because it's not a DropzoneFileInterface
                                  folder: '',
                                  filename: filename,
                                  localImageToDisplay: bytes,
                                );
                                controller.selectedImagesToUpload.add(image);
                              } else {
                                print('Zone unknown type: ${file.runtimeType}');
                              }
                            },
                          ),

                          /// Drop Zone Content
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(TImages.defaultMultiImageIcon,
                                  width: 50, height: 50),
                              const SizedBox(height: TSizes.spaceBtwItems),
                              const Text('Drag and Drop Images here'),
                              const SizedBox(height: TSizes.spaceBtwItems),
                              OutlinedButton(
                                  onPressed: () =>
                                      controller.selectLocalImages(),
                                  child: const Text('Select Images')),
                            ],
                          )
                        ],
                      ))
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),

                /// Heading & Locally Selected Images
                if (controller.selectedImagesToUpload.isNotEmpty)
                  TRoundedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Heading
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// Folders Dropdown
                            Row(
                              children: [
                                // Folder Dropdown
                                Text('Select Folder',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
                                const SizedBox(width: TSizes.spaceBtwItems),
                                MediaFolderDropdown(
                                  onChanged: (MediaCategory? newValue) {
                                    if (newValue != null) {
                                      controller.selectedPath.value = newValue;
                                    }
                                  },
                                ),
                              ],
                            ),

                            /// Upload & Remove Buttons
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () => controller
                                        .selectedImagesToUpload
                                        .clear(),
                                    child: const Text('Remove All')),
                                const SizedBox(width: TSizes.spaceBtwItems),
                                TDeviceUtils.isMobileScreen(context)
                                    ? const SizedBox.shrink()
                                    : SizedBox(
                                        width: TSizes.buttonWidth,
                                        child: ElevatedButton(
                                          onPressed: () => controller
                                              .uploadImagesConfirmation(),
                                          child: const Text('Upload'),
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        /// Locally Selected Images
                        Wrap(
                          alignment: WrapAlignment.start,
                          spacing: TSizes.spaceBtwItems / 2,
                          runSpacing: TSizes.spaceBtwItems / 2,
                          children: controller.selectedImagesToUpload
                              .where(
                                  (image) => image.localImageToDisplay != null)
                              .map((element) => TRoundedImage(
                                    width: 90,
                                    height: 90,
                                    padding: TSizes.sm,
                                    imageType: ImageType.memory,
                                    memoryImage: element.localImageToDisplay,
                                    backgroundColor: TColors.primaryBackground,
                                  ))
                              .toList(),
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        /// Upload Button for Mobile
                        TDeviceUtils.isMobileScreen(context)
                            ? SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () =>
                                        controller.uploadImagesConfirmation(),
                                    child: const Text('Upload')))
                            : const SizedBox.shrink()
                      ],
                    ),
                  ),
                const SizedBox(height: TSizes.spaceBtwSections),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
