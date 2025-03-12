import 'package:danastoreadminpanel/common/widgets/data_table/paginated_data_table.dart';
import 'package:danastoreadminpanel/features/shop/screens/order/all_orders/table/table_source.dart';
import 'package:danastoreadminpanel/utils/constants/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class OrdersTable extends StatelessWidget {
  const OrdersTable({super.key});

 @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth: 700,
      columns: [
        const DataColumn2(label: Text('Order ID')),
        const DataColumn2(label: Text('Date')),
        const DataColumn2(label: Text('Items')),
        DataColumn2(label: Text('Status'), fixedWidth: TDeviceUtils.isMobileScreen(context) ? 120 : null),
        const DataColumn2(label: Text('Amount')),
        const DataColumn2(label: Text('Action'), fixedWidth: 100),

      ],
      source: OrdersRows(),
    );
  }
}