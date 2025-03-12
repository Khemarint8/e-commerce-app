import 'package:danastoreadminpanel/common/widgets/breadcrumbs/breadcrumbsheading.dart';
import 'package:danastoreadminpanel/common/widgets/containers/rounded_container.dart';
import 'package:danastoreadminpanel/features/shop/screens/category/all_category/widgets/table_header.dart';
import 'package:danastoreadminpanel/features/shop/screens/customer/all_customer/table/data_table.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomerDesktopScreen extends StatelessWidget {
  const CustomerDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs
            TBreadcrumbsWithHeading(heading: 'Customers', breadcrumbItems: ['Customers']),
            SizedBox(height: TSizes.spaceBtwSections),

            TRoundedContainer(
              child: Column(
                children: [
                  // Table Header 
                  TTableHeader(showLeftWidget: false),
                  SizedBox(height: TSizes.spaceBtwItems),

                  // Table 
                  CustomerTable(),
                ],
              ),
            )
          ],
        ),),
      ),
    );
  }
}