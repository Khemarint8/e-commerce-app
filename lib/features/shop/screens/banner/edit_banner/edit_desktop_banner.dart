import 'package:danastoreadminpanel/features/shop/models/banner_model.dart';
import 'package:danastoreadminpanel/common/widgets/breadcrumbs/breadcrumbsheading.dart';
import 'package:danastoreadminpanel/features/shop/screens/banner/edit_banner/edit_banner_form.dart';
import 'package:danastoreadminpanel/routes/routes.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class EditDesktopBanner extends StatelessWidget {
  const EditDesktopBanner ({super.key, required this.banner});

  final BannerModel banner;

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
              const TBreadcrumbsWithHeading(returnToPreviousScreen: true,heading: 'Update Banner',breadcrumbItems: [RRoutes.banners, 'Update Banner']),

              const SizedBox(height: TSizes.spaceBtwSections),

              // Form 
              EditBannerForm(banner: banner)
            ],  
          ),),
      ),
    );
  }
}