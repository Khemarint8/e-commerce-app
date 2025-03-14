import 'package:danastoreadminpanel/app_screen.dart';
import 'package:danastoreadminpanel/common/widgets/containers/rounded_container.dart';
import 'package:danastoreadminpanel/common/widgets/images/t_rounded_image.dart';
import 'package:danastoreadminpanel/features/shop/controllers/banner/create_banner_controller.dart';
import 'package:danastoreadminpanel/utils/constants/colors.dart';
import 'package:danastoreadminpanel/utils/constants/enums.dart';
import 'package:danastoreadminpanel/utils/constants/image_strings.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CreateBannerForm extends StatelessWidget {
  const CreateBannerForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBannerController());
    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              const SizedBox(height: TSizes.sm),
              Text('Create New Banner',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Image Uploader & Featured Checkbox
              Column(
                children: [
                  Obx(
                    () => GestureDetector(
                      onTap: () => controller.pickImage(),
                      child: TRoundedImage(
                        width: 400,
                        height: 200,
                        backgroundColor: TColors.primaryBackground,
                        image: controller.imageUrl.value.isNotEmpty
                            ? controller.imageUrl.value
                            : TImages.defaultImage,
                        imageType: controller.imageUrl.value.isNotEmpty
                            ? ImageType.network
                            : ImageType.asset,
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TextButton(
                      onPressed: () => controller.pickImage(),
                      child: const Text('Select Image')),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              Text('Make your Banner Active or InActive',
                  style: Theme.of(context).textTheme.bodyMedium),
              Obx(() => CheckboxMenuButton(
                  value: controller.isActive.value,
                  onChanged: (value) =>
                      controller.isActive.value = value ?? false,
                  child: const Text('Active'))),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              //Dropdown Menu Screens
              Obx(() {
                return DropdownButton<String>(
                    value: controller.targetScreen.value,
                    onChanged: (String? newValue) =>
                        controller.targetScreen.value = newValue!,
                    items: AppScreen.allAppScreenItems
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList());
              }),
              const SizedBox(height: TSizes.spaceBtwInputFields * 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.createBanner(), child: const Text('Create')),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields * 2),
            ],
          )),
    );
  }
}
