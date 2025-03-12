import 'package:danastoreadminpanel/common/widgets/containers/rounded_container.dart';
import 'package:danastoreadminpanel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:danastoreadminpanel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:danastoreadminpanel/order.dart';
import 'package:danastoreadminpanel/routes/routes.dart';
import 'package:danastoreadminpanel/utils/constants/colors.dart';
import 'package:danastoreadminpanel/utils/constants/enums.dart';
import 'package:danastoreadminpanel/utils/constants/helpers/helper_functions.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OrdersRows extends DataTableSource {
  @override  
  DataRow? getRow(int index){
    final order = DashboardController.orders[index];
    return DataRow2(
      onTap: () => Get.toNamed(RRoutes.orderDetails, arguments: order),
      selected: false,
      onSelectChanged: (value){},
      cells: [
        DataCell(
          Text(
            order.id,
            style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: TColors.primary),
          ),
        ),
        DataCell(Text(order.formattedOrderDate)),
        DataCell(Text('${order.items.length} Items')),
        DataCell(
          TRoundedContainer(
            radius: TSizes.cardRadiusSm,
            padding: const EdgeInsets.symmetric(vertical: TSizes.sm, horizontal: TSizes.md),
            backgroundColor: THelperFunctions.getOrderStatusColor(order.status).withOpacity(0.1),
            child: Text(
              order.status.name.capitalize.toString(),
              style: TextStyle(color: THelperFunctions.getOrderStatusColor(order.status),
            ),
          )
        )
        ),
        DataCell(Text('\$${order.totalAmount}')),
        DataCell(
          TTableActionButtons(
            view: true,
            edit: false,
            onViewPressed: () => Get.toNamed(RRoutes.orderDetails, arguments: order, parameters: {'orderId': order.id}),
            onDeletePressed: (){},
          )
        )
      ]
    );
  }

  


  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => DashboardController.orders.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}