import 'package:danastoreadminpanel/common/widgets/containers/rounded_container.dart';
import 'package:danastoreadminpanel/features/shop/screens/dashboard/table/data_table.dart';
import 'package:danastoreadminpanel/features/shop/screens/dashboard/widgets/dashboard_card.dart';
import 'package:danastoreadminpanel/features/shop/screens/dashboard/widgets/orderStatusPieChart.dart';
import 'package:danastoreadminpanel/features/shop/screens/dashboard/widgets/weekly_sales.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              Text('Dashboard',
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: TSizes.spaceBtwSections),

              //Cards
              const Row(
                children: [
                  Expanded(
                    child: TDashboardCard(
                      stats: 25,
                      title: 'Sales total',
                      subTitle: '\$365.6',
                    ),
                  ),
                  SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(
                    child: TDashboardCard(
                      stats: 25,
                      title: 'Average Order Value',
                      subTitle: '\$365.6',
                    ),
                  ),
                  SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(
                    child: TDashboardCard(
                      stats: 25,
                      title: 'Total Orders',
                      subTitle: '\$365.6',
                    ),
                  ),
                  SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(
                    child: TDashboardCard(
                      stats: 25,
                      title: 'Visitor',
                      subTitle: '\$365.6',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// GRAPHS
              /// GRAPHS SECTION
               Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align items at the top
                children: [
                  /// **Bar Graph (Weekly Sales)**
                  Expanded(
                    flex: 2, // Gives more space to the bar graph
                    child: Column(
                      children: [
                        /// BAR GRAPH
                        const TWeeklySalesGraph(),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        /// **Orders Section**
                        TRoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Recent Orders', style: Theme.of(context).textTheme.headlineSmall),
                              const SizedBox(height: TSizes.spaceBtwSections),
                              const DashboardOrderTable(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// **Spacing Between Bar Chart and Pie Chart**
                  const SizedBox(width: TSizes.spaceBtwSections),

                  /// **Pie Chart**
                  const Expanded( // Pie chart takes less space
                    child: OrderStatusPieChart(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
