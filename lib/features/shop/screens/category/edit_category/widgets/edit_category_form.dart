import 'package:danastoreadminpanel/features/shop/controllers/category/category_controller.dart';
import 'package:danastoreadminpanel/features/shop/controllers/category/edit_category_controller.dart';
import 'package:danastoreadminpanel/features/shop/models/category_model.dart';
import 'package:danastoreadminpanel/common/widgets/containers/rounded_container.dart';
import 'package:danastoreadminpanel/common/widgets/images/image_uploader.dart';
import 'package:danastoreadminpanel/utils/constants/enums.dart';
import 'package:danastoreadminpanel/utils/constants/image_strings.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:danastoreadminpanel/utils/constants/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class EditCategoryForm extends StatelessWidget {
  const EditCategoryForm({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final editController = Get.put(EditCategoryController());
    editController.init(category);
    final categoryController = Get.put(CategoryController());
    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
          key: editController.formKey,
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          const SizedBox(height: TSizes.sm),
          Text('Update Category',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: TSizes.spaceBtwSections),

          // Name Text Field
          TextFormField(
            controller: editController.name,
            validator: (value) => TValidator.validateEmptyText('Name', value),
            decoration: const InputDecoration(
                labelText: 'Category Name', prefixIcon: Icon(Iconsax.category)),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          Obx(
            () => DropdownButtonFormField(
                decoration: const InputDecoration(
                    hintText: 'Parent Category',
                    labelText: 'Parent Category',
                    prefixIcon: Icon(Iconsax.bezier)),
                value: editController.selectedParent.value.id.isNotEmpty
                    ? editController.selectedParent.value
                    : null,
                onChanged: (newValue) =>
                    editController.selectedParent.value = newValue!,
                items: categoryController.allItems
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [Text(item.name)],
                          ),
                        ))
                    .toList()),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields * 2),

          Obx(
            () => TImageUploader(
              width: 80,
              height: 80,
              image: editController.imageURL.value.isNotEmpty ? editController.imageURL.value : TImages.defaultImage,
              imageType: editController.imageURL.value.isNotEmpty ? ImageType.network : ImageType.asset,
              onIconButtonPressed: () => editController.pickImage(),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

           Obx(
                () => CheckboxMenuButton(
                    value: editController.isFeatured.value,
                    onChanged: (value) => editController.isFeatured.value = value ?? false,
                    child: const Text('Featured')),
              ),
          const SizedBox(height: TSizes.spaceBtwInputFields * 2),

          SizedBox(
              width: double.infinity,
              child:
                  ElevatedButton(onPressed: () => editController.updateCategory(category), child: const Text('Update')),
            ),
          

          const SizedBox(height: TSizes.spaceBtwInputFields * 2),
        ],
      )),
    );
  }
}
