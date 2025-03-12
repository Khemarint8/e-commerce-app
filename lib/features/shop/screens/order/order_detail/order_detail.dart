import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:danastoreadminpanel/common/widgets/layouts/templates/site_layouts.dart';
import 'package:danastoreadminpanel/features/shop/screens/order/order_detail/responsive_screens/order_detail_desktop_screen.dart';
import 'package:danastoreadminpanel/features/shop/screens/order/order_detail/responsive_screens/order_detail_mobile.dart';
import 'package:danastoreadminpanel/features/shop/screens/order/order_detail/responsive_screens/order_detail_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OrdersDetailScreen extends StatelessWidget {
  const OrdersDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Store the order data first
    final order = Get.arguments;
    
    // Create each screen separately with the stored order data
    final desktopScreen = OrdersDetailDesktopScreens(order: order);
    final tabletScreen = OrdersDetailTabletScreens(order: order);
    final mobileScreen = OrdersDetailMobileScreens(order: order);
   

    // Pass the pre-built screens to TSiteTemplate
    return TSiteTemplate(
      desktop: desktopScreen,
      tablet: tabletScreen,
      mobile: mobileScreen,
    );
  }
}