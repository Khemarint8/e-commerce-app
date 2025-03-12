import 'package:danastoreadminpanel/common/widgets/breadcrumbs/breadcrumbsheading.dart';
import 'package:danastoreadminpanel/common/widgets/layouts/templates/site_layouts.dart';
import 'package:danastoreadminpanel/features/personalization/screen/profile/widgets/form.dart';
import 'package:danastoreadminpanel/features/personalization/screen/profile/widgets/image_meta.dart';
import 'package:danastoreadminpanel/features/personalization/screen/settings/responsive_screens/settings_desktop.dart';
import 'package:danastoreadminpanel/features/personalization/screen/settings/responsive_screens/settings_tablet.dart';
import 'package:danastoreadminpanel/features/personalization/screen/settings/responsive_screens/setttings_mobile.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: SettingDesktopScreen(),
      tablet: SettingTabletScreen(),
      mobile: SettingMobileScreen(),
    );
  }
}
