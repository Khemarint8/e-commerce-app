import 'package:danastoreadminpanel/common/widgets/breadcrumbs/breadcrumbsheading.dart';
import 'package:danastoreadminpanel/features/personalization/screen/settings/widtgets/image_metas.dart';
import 'package:danastoreadminpanel/features/personalization/screen/settings/widtgets/setingsform.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SettingTabletScreen extends StatelessWidget {
  const SettingTabletScreen({super.key});

   @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs
            TBreadcrumbsWithHeading(heading: 'Settings', breadcrumbItems: ['Settings']),
            SizedBox(height: TSizes.spaceBtwSections),

            // Body
             Column(
              children: [
                ImageAndMetas(),
                SizedBox(height: TSizes.spaceBtwSections),

                // Form
                SettingForm(),
              ],
            )
          ],
        ),),
      ),
    );
  }
}