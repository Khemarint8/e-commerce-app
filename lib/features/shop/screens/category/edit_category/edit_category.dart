import 'package:danastoreadminpanel/features/shop/models/category_model.dart';
import 'package:danastoreadminpanel/common/widgets/layouts/templates/site_layouts.dart';
import 'package:danastoreadminpanel/features/shop/screens/category/edit_category/responsive_screen/edit_category_desktop.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EditCategoriesScreen extends StatelessWidget {
  const EditCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = Get.arguments;
    return TSiteTemplate(desktop: EditCategoryDesktopScreen(category: category),
    // tablet: EditCategoryTabletScreen(category: category),
    // mobile: EditCategoryMobileScreen(category: category),);
    );
  }
}
