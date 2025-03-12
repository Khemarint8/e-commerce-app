import 'package:danastoreadminpanel/common/widgets/layouts/templates/site_layouts.dart';
import 'package:danastoreadminpanel/features/media/screen/media/responsive_screens/media_desktop.dart';
import 'package:danastoreadminpanel/features/media/screen/media/responsive_screens/media_mobile.dart';
import 'package:danastoreadminpanel/features/media/screen/media/responsive_screens/media_tablet.dart';
import 'package:flutter/cupertino.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({super.key});

  @override  
  Widget build(BuildContext context) {
    return const TSiteTemplate(desktop: MediaDesktopScreen(), tablet: MediaTabletScreen(), mobile: MediaMobileScreen());
  }
}