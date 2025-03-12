import 'package:danastoreadminpanel/common/widgets/layouts/templates/site_layouts.dart';
import 'package:danastoreadminpanel/features/authentication/screens/login/responsive_screens/login_desktop_tablet.dart';
import 'package:danastoreadminpanel/features/authentication/screens/login/responsive_screens/login_mobile.dart';
import 'package:flutter/material.dart';

class loginScreen extends StatelessWidget {
  const loginScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(useLayout: false,desktop: LoginDesktopTablet(), mobile: LoginScreenMobile());
  }
}