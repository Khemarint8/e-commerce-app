import 'package:danastoreadminpanel/common/widgets/breadcrumbs/breadcrumbsheading.dart';
import 'package:danastoreadminpanel/common/widgets/containers/rounded_container.dart';
import 'package:danastoreadminpanel/features/shop/screens/category/all_category/widgets/table_header.dart';
import 'package:danastoreadminpanel/features/shop/screens/order/all_orders/table/data_table.dart';
import 'package:danastoreadminpanel/features/shop/screens/product/all_products/table/product_table.dart';
import 'package:danastoreadminpanel/routes/routes.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OrdersDesktopScreens extends StatelessWidget {
  const OrdersDesktopScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs
            TBreadcrumbsWithHeading(heading: 'Orders', breadcrumbItems: ['Orders']),
            SizedBox(height: TSizes.spaceBtwSections),

            TRoundedContainer(
              child: Column(
                children: [
                  // Table Header 
                  TTableHeader(showLeftWidget: false),
                  SizedBox(height: TSizes.spaceBtwItems),

                  // Table 
                  OrdersTable(),
                ],
              ),
            )
          ],
        ),),
      ),
    );
  }
}