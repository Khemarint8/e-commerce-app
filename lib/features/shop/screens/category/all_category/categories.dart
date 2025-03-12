import 'package:danastoreadminpanel/common/widgets/layouts/templates/site_layouts.dart';
import 'package:danastoreadminpanel/features/shop/screens/category/all_category/responsive_screens/categories_desktop.dart';
import 'package:flutter/cupertino.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(desktop: CategoriesDesktopScreen());
  }
}
