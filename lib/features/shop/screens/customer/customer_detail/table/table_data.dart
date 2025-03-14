import 'package:danastoreadminpanel/common/widgets/data_table/paginated_data_table.dart';
import 'package:danastoreadminpanel/features/shop/screens/customer/customer_detail/table/table_source.dart';
import 'package:danastoreadminpanel/utils/constants/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class CustomerOrderTable extends StatelessWidget {
  const CustomerOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth: 550,
      tableHeight: 640,
      dataRowHeight: kMinInteractiveDimension,
      columns: [
        const DataColumn2(label: Text('Order ID')),
        const DataColumn2(label: Text('Date')),
        const DataColumn2(label: Text('Items')),
        DataColumn2(label: const Text('Status'), fixedWidth: TDeviceUtils.isMobileScreen(context) ? 100 : null),
        const DataColumn2(label: Text('Amount'), numeric: true),
      ],
      source: CustomerOrderRows(),
    );
  }
}