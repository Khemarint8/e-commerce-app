import 'package:danastoreadminpanel/common/widgets/breadcrumbs/breadcrumbsheading.dart';
import 'package:danastoreadminpanel/common/widgets/containers/rounded_container.dart';
import 'package:danastoreadminpanel/common/widgets/loaders/loader_animation.dart';
import 'package:danastoreadminpanel/features/shop/controllers/brand/brand_controller.dart';
import 'package:danastoreadminpanel/features/shop/screens/brand/all_brands/table/data_table.dart';
import 'package:danastoreadminpanel/features/shop/screens/category/all_category/widgets/table_header.dart';
import 'package:danastoreadminpanel/routes/routes.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandsDesktopScreen extends StatelessWidget {
  const BrandsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Breadcrumbs
              const TBreadcrumbsWithHeading(heading: 'Brands', breadcrumbItems: ['Brands']),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Table Body
              TRoundedContainer(
                child: Column(
                  children: [
                    // Table Header
                    TTableHeader(buttonText: 'Create New Brand', onPressed: () => Get.toNamed(RRoutes.createBrand), searchOnChanged: (query) => controller.searchQuery(query)),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    // Table
                    Obx(() {
                      // Show Loader
                      if (controller.isLoading.value) return const TLoaderAnimation();
                      return const BrandTable();
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}