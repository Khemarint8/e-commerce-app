import 'package:danastoreadminpanel/common/widgets/breadcrumbs/breadcrumbsheading.dart';
import 'package:danastoreadminpanel/common/widgets/containers/rounded_container.dart';
import 'package:danastoreadminpanel/common/widgets/loaders/loader_animation.dart';
import 'package:danastoreadminpanel/features/shop/controllers/product/product_controller.dart';
import 'package:danastoreadminpanel/features/shop/screens/category/all_category/widgets/table_header.dart';
import 'package:danastoreadminpanel/features/shop/screens/product/all_products/table/product_table.dart';
import 'package:danastoreadminpanel/routes/routes.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDesktopScreen extends StatelessWidget {
  const ProductDesktopScreen({super.key});

 @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs
            const TBreadcrumbsWithHeading(heading: 'Products', breadcrumbItems: ['Products']),
            const SizedBox(height: TSizes.spaceBtwSections),

            Obx(() {
              // Show Loader
              if (controller.isLoading.value) return const TLoaderAnimation();

              return TRoundedContainer(
                child: Column(
                  children: [
                    // Table Header 
                    TTableHeader(buttonText: 'Create Product', onPressed: () => Get.toNamed(RRoutes.createProduct), searchOnChanged: (query) => controller.searchQuery(query)),
                    const SizedBox(height: TSizes.spaceBtwItems),
              
                    // Table 
                    const ProductsTable(),
                  ],
                ),
              );
            }
              
            )
          ],
        ),),
      ),
    );
  }
}