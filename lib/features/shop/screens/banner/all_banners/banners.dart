import 'package:danastoreadminpanel/common/widgets/layouts/templates/site_layouts.dart';
import 'package:danastoreadminpanel/features/shop/screens/banner/all_banners/responsive_screens/banner_desktop.dart';
import 'package:flutter/cupertino.dart';

class BannerScreen extends StatelessWidget {
  const BannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(desktop: BannerDesktopScreen());
  }
}
