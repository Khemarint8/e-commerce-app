import 'package:danastoreadminpanel/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:danastoreadminpanel/utils/constants/text_strings.dart';
import 'package:danastoreadminpanel/utils/constants/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HeaderAndForm extends StatelessWidget {
  const HeaderAndForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Iconsax.arrow_left)),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text(TTexts.forgetPasswordTitle,
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text(TTexts.forgetPasswordSubTitle,
            style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: TSizes.spaceBtwSections * 2),
    
        /// Form
        Form(
          key: controller.forgetPasswordFormKey,
          child: TextFormField(
          controller: controller.email,
          validator: TValidator.validateEmail,
          decoration: const InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.direct_right)),
        )),
        const SizedBox(height: TSizes.spaceBtwSections),
    
        // Submit Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () => controller.sendPasswordResetEmail(),
              child: const Text(TTexts.submit)),
        ),
        const SizedBox(height: TSizes.spaceBtwSections * 2),
      ],
    );
  }
}
