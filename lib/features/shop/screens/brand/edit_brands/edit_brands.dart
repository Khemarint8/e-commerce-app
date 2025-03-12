import 'package:danastoreadminpanel/features/shop/models/brand_model.dart';
import 'package:danastoreadminpanel/common/widgets/layouts/templates/site_layouts.dart';
import 'package:danastoreadminpanel/features/shop/screens/brand/edit_brands/responsive_screen/edit_desktop_brands.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EditBrandScreen extends StatelessWidget {
  const EditBrandScreen({super.key, });


  @override
  Widget build(BuildContext context) {
    final brand = Get.arguments;
    return TSiteTemplate(desktop: EditDesktopBrands(brand: brand));
  }
}