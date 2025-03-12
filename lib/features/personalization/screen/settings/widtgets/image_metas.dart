import 'package:danastoreadminpanel/common/widgets/containers/rounded_container.dart';
import 'package:danastoreadminpanel/common/widgets/images/image_uploader.dart';
import 'package:danastoreadminpanel/utils/constants/enums.dart';
import 'package:danastoreadminpanel/utils/constants/image_strings.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

class ImageAndMetas extends StatelessWidget {
  const ImageAndMetas({super.key});

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
          Text('Dana Store',style: Theme.of(context).textTheme.headlineLarge,),
          
          const SizedBox(height: TSizes.spaceBtwSections),  // Spacing after content
        ],
      ),
    );
  }
}

