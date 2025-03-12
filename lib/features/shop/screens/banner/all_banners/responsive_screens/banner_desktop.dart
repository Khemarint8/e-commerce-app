import 'package:danastoreadminpanel/common/widgets/breadcrumbs/breadcrumbsheading.dart';
import 'package:danastoreadminpanel/common/widgets/containers/rounded_container.dart';
import 'package:danastoreadminpanel/common/widgets/loaders/loader_animation.dart';
import 'package:danastoreadminpanel/features/shop/controllers/banner/banner_controller.dart';
import 'package:danastoreadminpanel/features/shop/screens/banner/all_banners/table/banner_table.dart';
import 'package:danastoreadminpanel/features/shop/screens/category/all_category/widgets/table_header.dart';
import 'package:danastoreadminpanel/routes/routes.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerDesktopScreen extends StatelessWidget {
  const BannerDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs
            const TBreadcrumbsWithHeading(heading: 'Banners', breadcrumbItems: ['Banners']),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Table Body

            Obx(() {
              // Show Loader 
              if (controller.isLoading.value) return const TLoaderAnimation();
              return TRoundedContainer(
                child: Column(
                  children: [
                    // Table Header 
                    TTableHeader(buttonText: 'Create New Banner', onPressed: () => Get.toNamed(RRoutes.createBanner), showSearchField: false),
                    const SizedBox(height: TSizes.spaceBtwItems),
              
                    // Table 
                    const BannerTable(),
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