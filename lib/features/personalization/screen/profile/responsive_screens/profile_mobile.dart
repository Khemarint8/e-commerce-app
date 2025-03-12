import 'package:danastoreadminpanel/common/widgets/breadcrumbs/breadcrumbsheading.dart';
import 'package:danastoreadminpanel/features/personalization/screen/profile/widgets/form.dart';
import 'package:danastoreadminpanel/features/personalization/screen/profile/widgets/image_meta.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProfileMobileScreen extends StatelessWidget {
  const ProfileMobileScreen({super.key});

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

            Column(
              children: [
                ImageAndMeta(),
                SizedBox(height: TSizes.spaceBtwSections),

                // Form
                ProfileForm(),
              ],
            )
          ],
        ),),
      ),
    );
  }
}