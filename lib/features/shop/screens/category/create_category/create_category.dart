import 'package:danastoreadminpanel/common/widgets/layouts/templates/site_layouts.dart';
import 'package:danastoreadminpanel/features/shop/screens/category/create_category/responsive_screen/create_category_desktop.dart';
import 'package:flutter/cupertino.dart';

class CreateCategoriesScreen extends StatelessWidget {
  const CreateCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(desktop: CreateCategoryDesktopScreen());
  }
}
