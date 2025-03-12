import 'package:danastoreadminpanel/common/widgets/breadcrumbs/breadcrumbsheading.dart';
import 'package:danastoreadminpanel/features/shop/screens/customer/customer_detail/widgets/customerOrders.dart';
import 'package:danastoreadminpanel/features/shop/screens/customer/customer_detail/widgets/customerinfo.dart';
import 'package:danastoreadminpanel/features/shop/screens/customer/customer_detail/widgets/shipping_address.dart';
import 'package:danastoreadminpanel/routes/routes.dart';
import 'package:danastoreadminpanel/features/shop/models/user_model.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomerdetailDesktopScreen extends StatelessWidget {
  const CustomerdetailDesktopScreen({super.key, required this.customer});

  final UserModel customer;

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
              const TBreadcrumbsWithHeading(returnToPreviousScreen: true,
                  heading: 'Khemarint',
                  breadcrumbItems: [RRoutes.customers, 'Details']),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Body
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // left side customer information
                  Expanded(
                      child: Column(
                    children: [
                      //Customer Info
                      CustomerInfo(customer: customer),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      // Shipping Address
                      const ShippingAddress(),
                    ],
                  )),
                  const SizedBox(width: TSizes.spaceBtwSections),

                  // Right Side Customer Orders
                  const Expanded(flex: 2,child: Customerorders())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
