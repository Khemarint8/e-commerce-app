import 'package:danastoreadminpanel/common/widgets/shimmers/shimmer.dart';
import 'package:danastoreadminpanel/features/shop/controllers/category/category_controller.dart';
import 'package:danastoreadminpanel/features/shop/controllers/product/create_product_controller.dart';
import 'package:danastoreadminpanel/features/shop/controllers/product/edit_product_controller.dart';
import 'package:danastoreadminpanel/features/shop/controllers/product/product_controller.dart';
import 'package:danastoreadminpanel/features/shop/models/category_model.dart';
import 'package:danastoreadminpanel/common/widgets/containers/rounded_container.dart';
import 'package:danastoreadminpanel/features/shop/models/product_model.dart';
import 'package:danastoreadminpanel/utils/constants/helpers/cloud_helper_functions.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({super.key});

  @override
  Widget build(BuildContext context) {
    // Get instance of the CategoryController
    final categoriesController = Get.put(CategoryController());

    // Fetch categories if the list is empty
    if (categoriesController.allItems.isEmpty) {
      categoriesController.fetchItems();
    }

    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories label
          Text('Categories', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBtwItems),

          // MultiSelectDialogField for selecting categories

          Obx(
            () => categoriesController.isLoading.value
                ? const TShimmerEffect(width: double.infinity, height: 50)
                : MultiSelectDialogField(
                    buttonText: const Text('Select Categories'),
                    title: const Text('Categories'),
                    items: CategoryController.instance.allItems
                        .map((category) =>
                            MultiSelectItem(category, category.name))
                        .toList(),
                    listType: MultiSelectListType.CHIP,
                    onConfirm: (values) {
                      CreateProductController.instance.selectedCategories
                          .assignAll(values);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
