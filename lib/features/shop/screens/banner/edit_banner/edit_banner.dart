
import 'package:danastoreadminpanel/features/shop/models/banner_model.dart';
import 'package:danastoreadminpanel/common/widgets/layouts/templates/site_layouts.dart';
import 'package:danastoreadminpanel/features/shop/screens/banner/edit_banner/edit_desktop_banner.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EditBannerScreen extends StatelessWidget {
  const EditBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final banner = Get.arguments;
    return TSiteTemplate(desktop: EditDesktopBanner(banner: banner));
  }
}