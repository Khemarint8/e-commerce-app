import 'package:danastoreadminpanel/common/widgets/breadcrumbs/breadcrumbsheading.dart';
import 'package:danastoreadminpanel/features/shop/screens/brand/create_brands/widgets/create_brand_form.dart';
import 'package:danastoreadminpanel/routes/routes.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CreateDesktopBrands extends StatelessWidget {
  const CreateDesktopBrands({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              TBreadcrumbsWithHeading(returnToPreviousScreen: true,heading: 'Create Brand',breadcrumbItems: [RRoutes.brands, 'Create Brand']),

              SizedBox(height: TSizes.spaceBtwSections),

              // Form 
              CreateBrandForm()
            ],  
          ),),
      ),
    );
  }
}