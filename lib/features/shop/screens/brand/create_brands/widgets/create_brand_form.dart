import 'package:danastoreadminpanel/common/widgets/chips/rounded_choice_chips.dart';
import 'package:danastoreadminpanel/common/widgets/containers/rounded_container.dart';
import 'package:danastoreadminpanel/common/widgets/images/image_uploader.dart';
import 'package:danastoreadminpanel/features/shop/controllers/brand/create_brand_controller.dart';
import 'package:danastoreadminpanel/features/shop/controllers/category/category_controller.dart';
import 'package:danastoreadminpanel/utils/constants/enums.dart';
import 'package:danastoreadminpanel/utils/constants/image_strings.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:danastoreadminpanel/utils/constants/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class CreateBrandForm extends StatelessWidget {
  const CreateBrandForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBrandController());
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
          Text('Create New Brand',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: TSizes.spaceBtwSections),

          // Name Text Field
          TextFormField(
            controller: controller.name,
            validator: (value) => TValidator.validateEmptyText('Name', value),
            decoration: const InputDecoration(
                labelText: 'Brand New', prefixIcon: Icon(Iconsax.box)),
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
                  .map((category) => Padding(
                        padding: const EdgeInsets.only(bottom: TSizes.sm),
                        child: TChoiceChip(
                            text: category.name,
                            selected:
                                controller.selectedCategories.contains(category),
                            onSelected: (value) =>
                                controller.toggleSelection(category)),
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
              image: controller.imageURL.value.isNotEmpty ? controller.imageURL.value : TImages.defaultImage,
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
            child:
                ElevatedButton(onPressed: () => controller.createBrand(), child: const Text('Create')),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields * 2),
        ],
      )),
    );
  }
}
