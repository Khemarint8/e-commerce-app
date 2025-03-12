import 'package:danastoreadminpanel/common/widgets/breadcrumbs/breadcrumbsheading.dart';
import 'package:danastoreadminpanel/features/shop/screens/order/order_detail/widgets/order_customer.dart';
import 'package:danastoreadminpanel/features/shop/screens/order/order_detail/widgets/order_info.dart';
import 'package:danastoreadminpanel/features/shop/screens/order/order_detail/widgets/order_items.dart';
import 'package:danastoreadminpanel/features/shop/screens/order/order_detail/widgets/order_transaction.dart';
import 'package:danastoreadminpanel/order.dart';
import 'package:danastoreadminpanel/routes/routes.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OrdersDetailTabletScreens extends StatelessWidget {
  const OrdersDetailTabletScreens({super.key, required this.order});

  final OrderModel order;

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
              TBreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: order.id,
                breadcrumbItems: const [RRoutes.orders, 'Details']
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Customer Info at the top
              OrderCustomer(order: order),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Order Info
              OrderInfo(order: order),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Items
              OrderItems(order: order),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Transactions
              OrderTransaction(order: order),
            ],
          ),
        ),
      ),
    );
  }
}