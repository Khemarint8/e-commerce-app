import 'package:danastoreadminpanel/features/authentication/screens/reset_password/widgets/reset_password_widget.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ResetPassWordScreenMobile extends StatelessWidget {
  final String email;
  const ResetPassWordScreenMobile({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: ResetPasswordWidget(email: email), // Pass email
        ),
      ),
    );
  }
}
