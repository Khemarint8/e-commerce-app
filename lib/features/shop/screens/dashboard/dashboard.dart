import 'package:danastoreadminpanel/common/widgets/layouts/templates/site_layouts.dart';
import 'package:danastoreadminpanel/features/shop/screens/dashboard/responsive_screens/dashboard_desktop.dart';
import 'package:danastoreadminpanel/features/shop/screens/dashboard/responsive_screens/dashboard_mobile.dart';
import 'package:danastoreadminpanel/features/shop/screens/dashboard/responsive_screens/dashboard_tablet.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(desktop: DashboardDesktopScreen(), tablet: DashboardScreenTabletScreen(), mobile: DashboardMobileScreen());
  }
}