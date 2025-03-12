import 'package:danastoreadminpanel/common/widgets/layouts/templates/login_template.dart';
import 'package:danastoreadminpanel/features/authentication/screens/login/widgets/login_form.dart';
import 'package:danastoreadminpanel/features/authentication/screens/login/widgets/login_header.dart';
import 'package:flutter/material.dart';

class LoginDesktopTablet extends StatelessWidget {
  const LoginDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const TLoginTemplate(
      child: Column(
        children: [
          // Header
          LoginHeader(),

          // Form
          LoginForm()
        ],
      ),
    );
  }
}
