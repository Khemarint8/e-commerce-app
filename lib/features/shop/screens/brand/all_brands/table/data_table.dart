import 'package:danastoreadminpanel/common/widgets/data_table/paginated_data_table.dart';
import 'package:danastoreadminpanel/features/shop/controllers/brand/brand_controller.dart';
import 'package:danastoreadminpanel/features/shop/screens/brand/all_brands/table/table_source.dart';
import 'package:danastoreadminpanel/utils/constants/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BrandTable extends StatelessWidget {
  const BrandTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());

    return Obx(() {

      // If filtered items are empty, show the 'No brands available' message
      if (controller.filteredItems.isEmpty) {
        return const Center(child: Text("No brands available"));
      }

      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRows.length.toString());
      // Handle large table row height
      final lgTable = controller.filteredItems.any((element) =>
          element.brandCategories != null &&
          element.brandCategories!.length > 2);

      // Show table if data is available
      return TPaginatedDataTable(
        minWidth: 700,
        sortAscending: controller.sortAscending.value,
        sortColumnIndex: controller.sortColumnIndex.value,
        columns: [
          DataColumn2(
              label: const Text('Brand'),
              fixedWidth:
                  TDeviceUtils.isMobileScreen(Get.context!) ? null : 200,
              onSort: (columnIndex, ascending) =>
                  controller.sortByName(columnIndex, ascending)),
          const DataColumn2(label: Text('Categories')),
          DataColumn2(
              label: const Text('Featured'),
              fixedWidth:
                  TDeviceUtils.isMobileScreen(Get.context!) ? null : 100),
          DataColumn2(
              label: const Text('Date'),
              fixedWidth:
                  TDeviceUtils.isMobileScreen(Get.context!) ? null : 200),
          DataColumn2(
              label: const Text('Action'),
              fixedWidth:
                  TDeviceUtils.isMobileScreen(Get.context!) ? null : 100),
        ],
        source: BrandRows(),
      );
    });
  }
}
