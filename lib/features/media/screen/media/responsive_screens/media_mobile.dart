import 'package:danastoreadminpanel/common/widgets/breadcrumbs/breadcrumbsheading.dart';
import 'package:danastoreadminpanel/features/media/controllers/media_controller.dart';
import 'package:danastoreadminpanel/features/media/screen/media/widgets/media_content.dart';
import 'package:danastoreadminpanel/features/media/screen/media/widgets/media_uploader.dart';
import 'package:danastoreadminpanel/routes/routes.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MediaMobileScreen extends StatelessWidget {
  const MediaMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Breadcrumbs & Heading
                const TBreadcrumbsWithHeading(
                  heading: 'Media',
                  breadcrumbItems: [RRoutes.login, 'Media Screen'],
                ),

                const SizedBox(height: TSizes.spaceBtwItems),

                /// Upload Button (Now Simple & Auto-Sizing)
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () => controller.showImagesUploaderSection.value =
                        !controller.showImagesUploaderSection.value,
                    icon: const Icon(Iconsax.cloud_add, color: Colors.white),
                    label: const Text('Upload Images'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Adjusts padding instead of width
                    ),
                  ),
                ),

                const SizedBox(height: TSizes.spaceBtwItems),

                /// Upload Area
                const MediaUploader(),

                const SizedBox(height: TSizes.spaceBtwSections),

                /// Media Content (Takes remaining space)
                MediaContent(
                  allowSelection: false,
                  allowMultipleSelection: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
