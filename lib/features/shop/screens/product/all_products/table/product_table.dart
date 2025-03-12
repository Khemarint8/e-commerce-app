import 'package:danastoreadminpanel/common/widgets/data_table/paginated_data_table.dart';
import 'package:danastoreadminpanel/features/shop/controllers/product/product_controller.dart';
import 'package:danastoreadminpanel/features/shop/screens/product/all_products/table/table_source.dart';
import 'package:danastoreadminpanel/utils/constants/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProductsTable extends StatelessWidget {
  const ProductsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Obx(() {
      // Products & Selected Rows are Hidden => just to update the UI => Obx => [ProductRows]
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRows.length.toString());

      return TPaginatedDataTable(
        minWidth: 1000,
        sortAscending: controller.sortAscending.value,
        sortColumnIndex: controller.sortColumnIndex.value,
        columns: [
          DataColumn2(
            label: const Text('Product'),
            fixedWidth: !TDeviceUtils.isDesktopScreen(context) ? 300 : 400,
            onSort: (columnIndex, ascending) => controller.sortByName(columnIndex, ascending),
          ),
          DataColumn2(label: Text('Stock'), onSort: (columnIndex, ascending) => controller.sortByStock(columnIndex, ascending)),
          DataColumn2(label: Text('Sold'), onSort: (columnIndex, ascending) => controller.sortBySoldItems(columnIndex, ascending)),
          const DataColumn2(label: Text('Brand')),
          DataColumn2(label: Text('Price'), 
          onSort: (columnIndex, ascending) => controller.sortByPrice(columnIndex, ascending)),
          const DataColumn2(label: Text('Date')),
          const DataColumn2(label: Text('Action'), fixedWidth: 100),
      
        ],
        source: ProductsRows(),
      );
    }
      
    );
  }
}