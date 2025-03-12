import 'package:danastoreadminpanel/common/widgets/containers/rounded_container.dart';
import 'package:danastoreadminpanel/features/shop/screens/dashboard/table/data_table.dart';
import 'package:danastoreadminpanel/features/shop/screens/dashboard/widgets/dashboard_card.dart';
import 'package:danastoreadminpanel/features/shop/screens/dashboard/widgets/orderStatusPieChart.dart';
import 'package:danastoreadminpanel/features/shop/screens/dashboard/widgets/weekly_sales.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class DashboardScreenTabletScreen extends StatelessWidget {
  const DashboardScreenTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column( // Prevents infinite height issues
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              Text(
                'Dashboard',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
          
              // Cards
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
                      title: 'Sales total',
                      subTitle: '\$365.6',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              const Row(
                children: [
                  Expanded(
                      child: TDashboardCard(
                          title: 'Total Orders',
                          subTitle: '36',
                          stats: 44)),
                  SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(
                      child: TDashboardCard(
                          title: 'Visitors',
                          subTitle: '25,098',
                          stats: 2)),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Bar Graph 
              const TWeeklySalesGraph(),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Orders
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
              const SizedBox(height: TSizes.spaceBtwSections),

              // Pie Chart
              const OrderStatusPieChart(),
            ],
          ),
        ),
      ),
    );
  }
}
