import 'package:danastoreadminpanel/common/widgets/breadcrumbs/breadcrumbsheading.dart';
import 'package:danastoreadminpanel/common/widgets/containers/rounded_container.dart';
import 'package:danastoreadminpanel/features/shop/screens/category/all_category/widgets/table_header.dart';
import 'package:danastoreadminpanel/features/shop/screens/order/all_orders/table/data_table.dart';
import 'package:danastoreadminpanel/features/shop/screens/order/order_detail/widgets/order_customer.dart';
import 'package:danastoreadminpanel/features/shop/screens/order/order_detail/widgets/order_info.dart';
import 'package:danastoreadminpanel/features/shop/screens/order/order_detail/widgets/order_items.dart';
import 'package:danastoreadminpanel/features/shop/screens/order/order_detail/widgets/order_transaction.dart';
import 'package:danastoreadminpanel/order.dart';
import 'package:danastoreadminpanel/routes/routes.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OrdersDetailDesktopScreens extends StatelessWidget {
  const OrdersDetailDesktopScreens({super.key, required this.order});

  final OrderModel order;

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs
            TBreadcrumbsWithHeading(returnToPreviousScreen: true,heading: order.id,breadcrumbItems: const [RRoutes.orders, 'Details']),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Body 
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Side Order Information
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      // Order Info
                      OrderInfo(order:order),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      // Items
                      OrderItems(order: order),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      // Transactions
                      OrderTransaction(order: order)
                    ],
                  ),
                ),
                const SizedBox(width: TSizes.spaceBtwSections),

                // Right Side Order Orders
                Expanded(
                  child: Column(
                    children: [
                      // Customer Info
                      OrderCustomer(order: order),
                      const SizedBox(height: TSizes.spaceBtwSections),
                    ],
                  ),
                )
              ],
            )
          ],
        ),),
      ),
    );
  }
}