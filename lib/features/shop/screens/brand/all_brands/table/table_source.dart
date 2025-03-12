import 'package:danastoreadminpanel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:danastoreadminpanel/common/widgets/images/t_rounded_image.dart';
import 'package:danastoreadminpanel/features/shop/controllers/brand/brand_controller.dart';
import 'package:danastoreadminpanel/routes/routes.dart';
import 'package:danastoreadminpanel/utils/constants/colors.dart';
import 'package:danastoreadminpanel/utils/constants/device/device_utility.dart';
import 'package:danastoreadminpanel/utils/constants/enums.dart';
import 'package:danastoreadminpanel/utils/constants/image_strings.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BrandRows extends DataTableSource {
  final controller = BrandController.instance;

  @override
  DataRow? getRow(int index) {

     // Debug: print the index to see row being accessed;
    final brand = controller.filteredItems[index];
    return DataRow2(
      selected: controller.selectedRows[index],
      onSelectChanged: (value) =>
          controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          Row(
          children: [
            TRoundedImage(
              width: 50,
              height: 50,
              padding: TSizes.sm,
              image: brand.image,
              imageType: ImageType.network,
              borderRadius: TSizes.borderRadiusMd,
              backgroundColor: TColors.primaryBackground,
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            Expanded(
                child: Text(
              brand.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(Get.context!)
                  .textTheme
                  .bodyLarge!
                  .apply(color: TColors.primary),
            ))
          ],
        )),
        DataCell(
          Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.sm),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Wrap(
              spacing: TSizes.xs,
              direction: TDeviceUtils.isMobileScreen(Get.context!)
                  ? Axis.vertical
                  : Axis.horizontal,
              children: brand.brandCategories != null
                  ? brand.brandCategories!
                      .map((e) {
                       // Debugging the CategoryModel instance
                      print("Category Name: ${e.name}");
                      return Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    TDeviceUtils.isMobileScreen(Get.context!)
                                        ? 0
                                        : TSizes.xs),
                            child: Chip(
                                label: Text(e.name),
                                padding: const EdgeInsets.all(TSizes.xs)),
                          );
                      } 
                          )
                      .toList()
                  : [const SizedBox()],
            ),
          ),
        )),
        DataCell(brand.isFeatured ? const Icon(Iconsax.heart5, color: TColors.primary) : const Icon(Iconsax.heart)),
        DataCell(Text(brand.createdAt != null ? brand.formattedDate : '')),
        DataCell(
          TTableActionButtons(
          onEditPressed: () => Get.toNamed(RRoutes.editBrand, arguments: brand),
          onDeletePressed: () => controller.confirmAndDeleteItem(brand),
        ))
      ],
    );
  }

  @override
    int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((selected) => selected).length;

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;
}
