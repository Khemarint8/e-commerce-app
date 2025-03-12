import 'package:danastoreadminpanel/common/widgets/containers/rounded_container.dart';
import 'package:danastoreadminpanel/common/widgets/images/image_uploader.dart';
import 'package:danastoreadminpanel/utils/constants/enums.dart';
import 'package:danastoreadminpanel/utils/constants/image_strings.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ImageAndMeta extends StatelessWidget {
  const ImageAndMeta({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.symmetric(
        vertical: TSizes.lg,
        horizontal: TSizes.md,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,  // Center horizontally
        children: [
          // User Image
          const TImageUploader(
            right: 10,
            bottom: 20,
            left: null,
            width: 200,
            height: 200,
            circular: true,
            icon: Iconsax.camera,
            imageType: ImageType.asset,
            image: TImages.defaultSingleImageIcon,
          ),
          
          const SizedBox(height: TSizes.spaceBtwItems),  // Spacing between image and text
          
          // User Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,  // Center text horizontally
            children: [
              Text(
                'Khemarint Phong',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const Text('khemrent25@gmail.com'),
            ],
          ),
          
          const SizedBox(height: TSizes.spaceBtwSections),  // Spacing after content
        ],
      ),
    );
  }
}
