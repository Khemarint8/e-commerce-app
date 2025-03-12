import 'package:danastoreadminpanel/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:danastoreadminpanel/features/authentication/screens/login/login.dart';
import 'package:danastoreadminpanel/routes/routes.dart';
import 'package:danastoreadminpanel/utils/constants/image_strings.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:danastoreadminpanel/utils/constants/text_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordWidget extends StatelessWidget {
  const ResetPasswordWidget({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Header
        Row(
          children: [
            IconButton(
              onPressed: () => Get.offAllNamed(RRoutes.login),
              icon: const Icon(CupertinoIcons.clear),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        /// Image
        const Image(
          image: AssetImage(TImages.deliveredEmailIllustration),
          width: 300,
          height: 300,
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        /// Title & SubTitle
        Text(
          TTexts.changeYourPasswordTitle,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        /// Display Email
        Text(
          email, // Use the passed email parameter
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        Text(
          TTexts.changeYourPasswordSubTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: TSizes.spaceBtwSections),

        /// Buttons
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.offAll(() => const loginScreen()),
            child: const Text(TTexts.done),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () => ForgetPasswordController.instance.resendPasswordResetEmail(email),
            child: const Text(TTexts.resendEmail),
          ),
        ),
      ],
    );
  }
}
