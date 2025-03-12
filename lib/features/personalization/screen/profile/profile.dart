import 'package:danastoreadminpanel/common/widgets/layouts/templates/site_layouts.dart';
import 'package:danastoreadminpanel/features/personalization/screen/profile/responsive_screens/profile_desktop.dart';
import 'package:danastoreadminpanel/features/personalization/screen/profile/responsive_screens/profile_mobile.dart';
import 'package:danastoreadminpanel/features/personalization/screen/profile/responsive_screens/profile_tablet.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: ProfileDesktopScreen(),
      tablet: ProfileTabletScreen(),
      mobile: ProfileMobileScreen(),
    );
  }
}
