import 'package:danastoreadminpanel/common/widgets/layouts/templates/site_layouts.dart';
import 'package:danastoreadminpanel/features/authentication/screens/reset_password/response_screens/reset_password_desktop_tablet.dart';
import 'package:danastoreadminpanel/features/authentication/screens/reset_password/response_screens/reset_password_mobile.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      useLayout: false, 
      desktop: ResetPasswordScreenDesktopTablet(email: email), 
      mobile: ResetPassWordScreenMobile(email: email),
    );
  }
}
