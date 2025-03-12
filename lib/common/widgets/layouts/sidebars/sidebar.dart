import 'package:danastoreadminpanel/common/widgets/images/t_circular_image.dart';
import 'package:danastoreadminpanel/common/widgets/layouts/sidebars/menu/menuItem.dart';
import 'package:danastoreadminpanel/routes/routes.dart';
import 'package:danastoreadminpanel/utils/constants/colors.dart';
import 'package:danastoreadminpanel/utils/constants/image_strings.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TSidebar extends StatelessWidget {
  const TSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Container(
        decoration: const BoxDecoration(
          color: TColors.white,
          border: Border(right: BorderSide(color: TColors.grey, width: 1))
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image
              const TCircularImage(width: 100, height: 100, image: TImages.darkAppLogo, backgroundColor: Colors.transparent),
              const SizedBox(height: TSizes.spaceBtwSections),
              Padding(
                padding: const EdgeInsets.all(TSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('MENU', style: Theme.of(context).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2)),

                    // Menu Items
                    const TMenuItem(route: RRoutes.dashboard, icon: Iconsax.status, itemName: 'Dashboard'),
                    const TMenuItem(route: RRoutes.media, icon: Iconsax.image, itemName: 'Media'),
                    const TMenuItem(route: RRoutes.categories, icon: Iconsax.category, itemName: 'Categories'),
                    const TMenuItem(route: RRoutes.brands, icon: Iconsax.dcube, itemName: 'Brands'),
                    const TMenuItem(route: RRoutes.banners, icon: Iconsax.picture_frame, itemName: 'Banners'),
                    const TMenuItem(route: RRoutes.products, icon: Iconsax.shopping_bag, itemName: 'Products'),
                    const TMenuItem(route: RRoutes.customers, icon: Iconsax.profile_2user, itemName: 'Customers'),
                    const TMenuItem(route: RRoutes.orders, icon: Iconsax.box, itemName: 'Orders'),
                     Text('OTHERS', style: Theme.of(context).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2)),
                    const TMenuItem(route: RRoutes.profile, icon: Iconsax.user, itemName: 'Profile'),
                    const TMenuItem(route: RRoutes.settings, icon: Iconsax.setting, itemName: 'Settings'),
                    const TMenuItem(route: 'logout', icon: Iconsax.logout, itemName: 'Logout'),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );}
}

