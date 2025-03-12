import 'package:danastoreadminpanel/features/shop/controllers/banner/banner_controller.dart';
import 'package:danastoreadminpanel/features/shop/models/banner_model.dart';
import 'package:danastoreadminpanel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:danastoreadminpanel/common/widgets/images/t_rounded_image.dart';
import 'package:danastoreadminpanel/routes/routes.dart';
import 'package:danastoreadminpanel/utils/constants/colors.dart';
import 'package:danastoreadminpanel/utils/constants/enums.dart';
import 'package:danastoreadminpanel/utils/constants/image_strings.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BannerRows extends DataTableSource {
  final controller = BannerController.instance;
  @override
  DataRow? getRow(int index) {
    final banner = controller.filteredItems[index];
    return DataRow2(
      selected: controller.selectedRows[index],
      onTap: () => Get.toNamed(RRoutes.editBanner, arguments: banner),
      onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
      cells: [
      DataCell(
        TRoundedImage(
          width: 180,
          height: 100,
          padding: TSizes.sm,
          image: banner.imageUrl,
          imageType: ImageType.network,
          borderRadius: TSizes.borderRadiusMd,
          backgroundColor: TColors.primaryBackground,
        ),
      ),
      DataCell(Text(controller.formatRoute(banner.targetScreen))),
      DataCell(banner.active ? const Icon(Iconsax.eye, color: TColors.primary) : const Icon(Iconsax.eye_slash)),
      DataCell(
        TTableActionButtons(
          onEditPressed: () => Get.toNamed(RRoutes.editBanner, arguments: banner),
          onDeletePressed: () => controller.confirmAndDeleteItem(banner),
        )
      )
    ]);
  }
  
  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;
  
  @override
  // TODO: implement rowCount
  int get rowCount => controller.filteredItems.length;
  
  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => controller.selectedRows.where((selected) => selected).length;
}
