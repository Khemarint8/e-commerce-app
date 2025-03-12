import 'package:danastoreadminpanel/common/widgets/layouts/templates/login_template.dart';
import 'package:danastoreadminpanel/features/authentication/screens/forget_password/widgets/header_form.dart';
import 'package:flutter/material.dart';

class ForgetPasswordDesktopTablet extends StatelessWidget {
  const ForgetPasswordDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const TLoginTemplate(
      child: HeaderAndForm(),
    );
  }
}

