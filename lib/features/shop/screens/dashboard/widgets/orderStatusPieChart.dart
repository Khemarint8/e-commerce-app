import 'package:danastoreadminpanel/common/widgets/containers/circular_container.dart';
import 'package:danastoreadminpanel/common/widgets/containers/rounded_container.dart';
import 'package:danastoreadminpanel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:danastoreadminpanel/utils/constants/enums.dart';
import 'package:danastoreadminpanel/utils/constants/helpers/helper_functions.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderStatusPieChart extends StatelessWidget {
  const OrderStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Orders Status',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBtwItems),
          // Graph
          SizedBox(
            height: 400,
            width: double.infinity,
            child: Obx(()
              => PieChart(
                PieChartData(
                    sections: controller.orderStatusData.entries.map((entry) {
                      final status = entry.key;
                      final count = entry.value;

                      print(
                          "Creating Pie Section: $status - $count");
                      return PieChartSectionData(
                        title: count.toString(),
                        value: count.toDouble(),
                        radius: 100,
                        titleStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        color: THelperFunctions.getOrderStatusColor(entry.key),
                      );
                    }).toList(),
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {},
                      enabled: true,
                    )),
              ),
            ),
          ),
          // Show Status and Color Meta
          SizedBox(
            width: double.infinity,
            child: DataTable(columns: const [
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Orders')),
              DataColumn(label: Text('Total')),
            ],
             rows: controller.orderStatusData.entries.map((entry){
              final OrderStatus status = entry.key;
              final int count = entry.value;
              final totalAmount = controller.totalAmounts[status] ?? 0;
            
              return DataRow(cells: [
                DataCell(
                  Row(
                    children: [
                      TCircularContainer(width: 20, height: 20, backgroundColor: THelperFunctions.getOrderStatusColor(status)),
                      Expanded(child: Text(' ${controller.getDisplayStatusName(status)}')),
                    ],
                  )
                ),
                DataCell(Text(count.toString())),
                DataCell(Text('\$${totalAmount.toStringAsFixed(2)}')),
              ]);
            }).toList()),
          ),
        ],
      ),
    );
  }
}
