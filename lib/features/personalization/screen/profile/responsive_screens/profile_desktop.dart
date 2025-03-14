import 'package:danastoreadminpanel/common/widgets/breadcrumbs/breadcrumbsheading.dart';
import 'package:danastoreadminpanel/common/widgets/containers/rounded_container.dart';
import 'package:danastoreadminpanel/features/personalization/screen/profile/profile.dart';
import 'package:danastoreadminpanel/features/personalization/screen/profile/widgets/form.dart';
import 'package:danastoreadminpanel/features/personalization/screen/profile/widgets/image_meta.dart';
import 'package:danastoreadminpanel/features/shop/screens/category/all_category/widgets/table_header.dart';
import 'package:danastoreadminpanel/routes/routes.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfileDesktopScreen extends StatelessWidget {
  const ProfileDesktopScreen({super.key});

   @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs
            TBreadcrumbsWithHeading(heading: 'Profile', breadcrumbItems: ['Profile']),
            SizedBox(height: TSizes.spaceBtwSections),

            // Body
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Pic and Meta
                Expanded(child: ImageAndMeta()),
                SizedBox(width: TSizes.spaceBtwSections),

                // Form
                Expanded(flex: 2,child: ProfileForm())
              ],
            )
          ],
        ),),
      ),
    );
  }
}