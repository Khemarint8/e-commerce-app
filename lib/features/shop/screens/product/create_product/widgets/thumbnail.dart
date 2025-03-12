import 'package:danastoreadminpanel/common/widgets/containers/rounded_container.dart';
import 'package:danastoreadminpanel/common/widgets/images/t_rounded_image.dart';
import 'package:danastoreadminpanel/features/shop/controllers/product/product_images_controller.dart';
import 'package:danastoreadminpanel/utils/constants/colors.dart';
import 'package:danastoreadminpanel/utils/constants/enums.dart';
import 'package:danastoreadminpanel/utils/constants/image_strings.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductThumbnailImage extends StatelessWidget {
  const ProductThumbnailImage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductImagesController());
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Thumbnail text
          Text('Product Thumbnail',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBtwItems),

          // Container for Product thumbnail
          TRoundedContainer(
            height: 300,
            backgroundColor: TColors.primaryBackground,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Thumbnail Image
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Obx(
                        () => TRoundedImage(
                          width: 220,
                          height: 220,
                          image: controller.selectedThumbnailImageUrl.value ??
                              TImages.defaultSingleImageIcon,
                          imageType:
                              controller.selectedThumbnailImageUrl.value == null
                                  ? ImageType.asset
                                  : ImageType.network,
                        ),
                      ))
                    ],
                  ),

                  // Add Thumbnail Button
                  SizedBox(
                      width: 200,
                      child: OutlinedButton(
                          onPressed: () => controller.selectThumbnailImage(),
                          child: const Text('Add Thumbnail')))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
