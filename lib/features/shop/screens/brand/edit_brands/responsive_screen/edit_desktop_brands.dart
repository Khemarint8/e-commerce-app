import 'package:danastoreadminpanel/features/shop/models/brand_model.dart';
import 'package:danastoreadminpanel/common/widgets/breadcrumbs/breadcrumbsheading.dart';
import 'package:danastoreadminpanel/features/shop/screens/brand/create_brands/widgets/create_brand_form.dart';
import 'package:danastoreadminpanel/features/shop/screens/brand/edit_brands/edit_brands.dart';
import 'package:danastoreadminpanel/features/shop/screens/brand/edit_brands/widgets/edit_brands_form.dart';
import 'package:danastoreadminpanel/routes/routes.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class EditDesktopBrands extends StatelessWidget {
  const EditDesktopBrands ({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbsWithHeading(returnToPreviousScreen: true,heading: 'Update Brand',breadcrumbItems: [RRoutes.brands, 'Update Brand']),

              const SizedBox(height: TSizes.spaceBtwSections),

              // Form 
              EditBrandsForm(brand: brand),
            ],  
          ),),
      ),
    );
  }
}