import 'package:danastoreadminpanel/common/widgets/layouts/templates/site_layouts.dart';
import 'package:danastoreadminpanel/features/shop/screens/customer/customer_detail/responsive_screen/customerdetail_desktop_screen.dart';
import 'package:danastoreadminpanel/features/shop/screens/customer/customer_detail/responsive_screen/customerdetail_mobile.dart';
import 'package:danastoreadminpanel/features/shop/screens/customer/customer_detail/responsive_screen/customerdetail_tablet.dart';
import 'package:danastoreadminpanel/features/shop/models/user_model.dart';
import 'package:flutter/material.dart';

class CustomerDetailScreen extends StatelessWidget {
  const CustomerDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customer = UserModel(email: '');
    return TSiteTemplate(desktop: CustomerdetailDesktopScreen(customer: customer),tablet: CustomerdetailTabletScreen(customer: customer),mobile: CustomerdetailMobileScreen(customer: customer,),);
  }
}