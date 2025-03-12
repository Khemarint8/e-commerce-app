import 'package:danastoreadminpanel/common/widgets/layouts/templates/site_layouts.dart';
import 'package:danastoreadminpanel/features/shop/controllers/product/edit_product_controller.dart';
import 'package:danastoreadminpanel/features/shop/screens/product/edit_product/responsive_screens/edit_desktop_product.dart';
import 'package:danastoreadminpanel/features/shop/screens/product/edit_product/responsive_screens/edit_mobile_product.dart';
import 'package:danastoreadminpanel/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EditProductsScreen extends StatelessWidget {
  const EditProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: EditProductDesktopScreen(),
      mobile: EditProductMobileScreen(),
    );
  }
}
