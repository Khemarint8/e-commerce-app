import 'package:danastoreadminpanel/common/widgets/breadcrumbs/breadcrumbsheading.dart';
import 'package:danastoreadminpanel/common/widgets/containers/rounded_container.dart';
import 'package:danastoreadminpanel/features/shop/screens/product/create_product/widgets/product_additional_iamges.dart';
import 'package:danastoreadminpanel/features/shop/screens/product/create_product/widgets/product_attribute.dart';
import 'package:danastoreadminpanel/features/shop/screens/product/create_product/widgets/product_bottomnavigationbuttons.dart';
import 'package:danastoreadminpanel/features/shop/screens/product/create_product/widgets/product_brand.dart';
import 'package:danastoreadminpanel/features/shop/screens/product/create_product/widgets/product_categories.dart';
import 'package:danastoreadminpanel/features/shop/screens/product/create_product/widgets/product_type.dart';
import 'package:danastoreadminpanel/features/shop/screens/product/create_product/widgets/product_variation.dart';
import 'package:danastoreadminpanel/features/shop/screens/product/create_product/widgets/product_visibility.dart';
import 'package:danastoreadminpanel/features/shop/screens/product/create_product/widgets/stockandpricing.dart';
import 'package:danastoreadminpanel/features/shop/screens/product/create_product/widgets/thumbnail.dart';
import 'package:danastoreadminpanel/features/shop/screens/product/create_product/widgets/title_description.dart';
import 'package:danastoreadminpanel/features/shop/models/product_model.dart';
import 'package:danastoreadminpanel/routes/routes.dart';
import 'package:danastoreadminpanel/utils/constants/device/device_utility.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class EditProductDesktopScreen extends StatelessWidget {
  const EditProductDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  ProductBottomNavigationButtons(),
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs
            const TBreadcrumbsWithHeading(
              returnToPreviousScreen: true,heading: 'Update Products', breadcrumbItems: [RRoutes.products, 'Update Products']),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Create Product
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: TDeviceUtils.isTabletScreen(context) ? 2 : 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Basic Information
                      const ProductTitleAndDescription(),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      // Stock & Pricing 
                      TRoundedContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Heading 
                            Text('Stack & Pricing', style: Theme.of(context).textTheme.headlineSmall),
                            const SizedBox(height: TSizes.spaceBtwItems),

                            // Product Type
                            const ProductTypeWidget(),
                            const SizedBox(height: TSizes.spaceBtwInputFields),

                            // Stock 
                            const ProductStockAndPricing(),
                            const SizedBox(height: TSizes.spaceBtwSections),

                            // Attributes 
                            const ProductAttributes(),
                            const SizedBox(height: TSizes.spaceBtwSections),
                          ],
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      // Variations 
                       const ProductVariations(),
                    ],
                  ),
                ),
                const SizedBox(width: TSizes.defaultSpace),

                // Sidebar 
                Expanded(
                  child: Column(
                    children: [
                      // Product Thumbnail
                      const ProductThumbnailImage(),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      // Product Images
                      TRoundedContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('All Product Images', style: Theme.of(context).textTheme.headlineSmall),
                            const SizedBox(height: TSizes.spaceBtwItems),
                            ProductAdditionalImages(
                              additionalProductImagesURLs: RxList<String>.empty(),
                              onTapToAddImages: (){},
                              onTapToRemoveImage: (index){},
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      // Product Brand
                      const ProductBrand(),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      // Product Categories 
                       ProductCategories(),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      // Product Visibility
                      const ProductVisibilityWidget(),
                      const SizedBox(height: TSizes.spaceBtwSections),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),),
      ),
    );
  }
}