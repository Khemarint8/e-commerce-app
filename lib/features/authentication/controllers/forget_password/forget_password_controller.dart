import 'package:danastoreadminpanel/data/repositories/authentication/authentication_repository.dart';
import 'package:danastoreadminpanel/features/authentication/screens/reset_password/reset_password.dart';
import 'package:danastoreadminpanel/utils/constants/helpers/network_manager.dart';
import 'package:danastoreadminpanel/utils/constants/image_strings.dart';
import 'package:danastoreadminpanel/utils/constants/popups/full_screen_loader.dart';
import 'package:danastoreadminpanel/utils/constants/popups/loaders.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController{
  static ForgetPasswordController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  RxBool canResendEmail = true.obs;
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  /// Send Reset Password Email
  sendPasswordResetEmail() async {
    try{
      // Start Loading 
      TFullScreenLoader.openLoadingDialog('Processing your request', TImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {TFullScreenLoader.stopLoading(); return;}

      // Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Send Email to Rest Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show Success Screen
      TLoaders.successSnackBar(title: 'Email Sent', message: 'Email Link Sent to Reset your Password'.tr);

      // Redirect 
       Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      // Remove loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

   resendPasswordResetEmail(String email) async {
    if (!canResendEmail.value) {
      TLoaders.errorSnackBar(
          title: 'Wait to Resend',
          message: 'Please wait before resending the email.');
      return;
    }
    try{
      // Start Loading 
     TFullScreenLoader.openLoadingDialog('Processing your request', TImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {TFullScreenLoader.stopLoading(); return;}

      // Send Email to Reset Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      // Update cooldown status
      canResendEmail.value = false;
      Future.delayed(const Duration(minutes: 1), () => canResendEmail.value = true); // Cooldown period
      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show Success Screen 
      TLoaders.successSnackBar(title:'Email Sent',message: 'Email Link Sent to Reset your Password'.tr);

    } catch (e) {
      // Remove Loader 
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap',message: e.toString());
    }
  }
}