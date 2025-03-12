import 'package:danastoreadminpanel/features/shop/controllers/brand/create_brand_controller.dart';
import 'package:danastoreadminpanel/features/shop/controllers/brand/edit_brand_controller.dart';
import 'package:danastoreadminpanel/features/shop/controllers/category/category_controller.dart';
import 'package:danastoreadminpanel/features/shop/models/brand_model.dart';
import 'package:danastoreadminpanel/common/widgets/chips/rounded_choice_chips.dart';
import 'package:danastoreadminpanel/common/widgets/containers/rounded_container.dart';
import 'package:danastoreadminpanel/common/widgets/images/image_uploader.dart';
import 'package:danastoreadminpanel/utils/constants/enums.dart';
import 'package:danastoreadminpanel/utils/constants/image_strings.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:danastoreadminpanel/utils/constants/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

class EditBrandsForm extends StatelessWidget {
  const EditBrandsForm({super.key, required this.brand});
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditBrandController());
    controller.init(brand);
    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
          key: controller.formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              const SizedBox(height: TSizes.sm),
              Text('Update Brand',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Name Text Field
              TextFormField(
                controller: controller.name,
                validator: (value) =>
                    TValidator.validateEmptyText('Name', value),
                decoration: const InputDecoration(
                    labelText: 'Brand Name',
                    prefixIcon: Icon(Iconsax.category)),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              // Categories
              Text('Select Categories',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: TSizes.spaceBtwInputFields / 2),
              Obx(
                () => Wrap(
                  spacing: TSizes.sm,
                  children: CategoryController.instance.allItems
                      .map((element) => Padding(
                            padding: const EdgeInsets.only(bottom: TSizes.sm),
                            child: TChoiceChip(
                              text: element.name,
                              selected: controller.selectedCategories
                                  .contains(element),
                              onSelected: (value) =>
                                  controller.toggleSelection(element),
                            ),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields * 2),

              // Image Uploader & Featured Checkbox
              Obx(
                () => TImageUploader(
                  width: 80,
                  height: 80,
                  image: controller.imageURL.isNotEmpty ? controller.imageURL.value : TImages.defaultImage,
                  imageType: controller.imageURL.value.isNotEmpty ? ImageType.network : ImageType.asset,
                  onIconButtonPressed: () => controller.pickImage(),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              // Checkbox
              Obx(
                () => CheckboxMenuButton(
                    value: controller.isFeatured.value,
                    onChanged: (value) => controller.isFeatured.value = value ?? false,
                    child: const Text('Featured')),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields * 2),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.updateBrand(brand), child: const Text('Update')),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields * 2),
            ],
          )),
    );
  }
}
