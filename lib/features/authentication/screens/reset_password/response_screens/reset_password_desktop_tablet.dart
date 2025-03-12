import 'package:danastoreadminpanel/common/widgets/layouts/templates/login_template.dart';
import 'package:danastoreadminpanel/features/authentication/screens/reset_password/widgets/reset_password_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreenDesktopTablet extends StatelessWidget {
  final String email;
  const ResetPasswordScreenDesktopTablet({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return TLoginTemplate(
      child: ResetPasswordWidget(email: email), // Pass email
    );
  }
}
