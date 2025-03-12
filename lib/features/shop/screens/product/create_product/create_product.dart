import 'package:danastoreadminpanel/common/widgets/layouts/templates/site_layouts.dart';
import 'package:danastoreadminpanel/features/shop/controllers/product/edit_product_controller.dart';
import 'package:danastoreadminpanel/features/shop/screens/product/create_product/repositories_screen/create_product_desktop.dart';
import 'package:danastoreadminpanel/features/shop/screens/product/create_product/repositories_screen/create_product_mobile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CreateProductsScreen extends StatelessWidget {
   CreateProductsScreen({super.key});


  @override
  Widget build(BuildContext context) {
  
      final desktopScreen = CreateProductDesktopScreen();
    final mobileScreen = CreateProductMobileScreen();
    return  TSiteTemplate(desktop: desktopScreen,mobile: mobileScreen);
  }
}