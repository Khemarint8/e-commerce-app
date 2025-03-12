import 'package:danastoreadminpanel/features/media/screen/media/media.dart';
import 'package:danastoreadminpanel/features/personalization/screen/profile/profile.dart';
import 'package:danastoreadminpanel/features/personalization/screen/settings/settings.dart';
import 'package:danastoreadminpanel/features/shop/screens/banner/all_banners/banners.dart';
import 'package:danastoreadminpanel/features/shop/screens/banner/create_banner/create_banner.dart';
import 'package:danastoreadminpanel/features/shop/screens/banner/edit_banner/edit_banner.dart';
import 'package:danastoreadminpanel/features/shop/screens/brand/all_brands/brands.dart';
import 'package:danastoreadminpanel/features/shop/screens/brand/create_brands/create_brands.dart';
import 'package:danastoreadminpanel/features/shop/screens/brand/edit_brands/edit_brands.dart';
import 'package:danastoreadminpanel/features/shop/screens/category/all_category/categories.dart';
import 'package:danastoreadminpanel/features/shop/screens/category/create_category/create_category.dart';
import 'package:danastoreadminpanel/features/shop/screens/category/edit_category/edit_category.dart';
import 'package:danastoreadminpanel/features/shop/screens/customer/all_customer/customer.dart';
import 'package:danastoreadminpanel/features/shop/screens/customer/customer_detail/customerdetail.dart';
import 'package:danastoreadminpanel/features/shop/screens/dashboard/dashboard.dart';
import 'package:danastoreadminpanel/features/authentication/screens/forget_password/forget_password.dart';
import 'package:danastoreadminpanel/features/authentication/screens/login/login.dart';
import 'package:danastoreadminpanel/features/authentication/screens/reset_password/reset_password.dart';
import 'package:danastoreadminpanel/features/shop/screens/order/all_orders/orders.dart';
import 'package:danastoreadminpanel/features/shop/screens/order/order_detail/order_detail.dart';
import 'package:danastoreadminpanel/features/shop/screens/product/all_products/products.dart';
import 'package:danastoreadminpanel/features/shop/screens/product/create_product/create_product.dart';
import 'package:danastoreadminpanel/features/shop/screens/product/edit_product/edit_product.dart';
import 'package:danastoreadminpanel/routes/routes.dart';
import 'package:danastoreadminpanel/routes/routes_middleware.dart';
import 'package:get/get.dart';

class RAppRoutes {
   
  static final List<GetPage> pages = [
   GetPage(name: RRoutes.login, page: () => const loginScreen()),
   GetPage(name: RRoutes.forgetPassword, page: () => const ForgetPasswordScreen()),
    GetPage(
      name: RRoutes.resetPassword,
      page: () => ResetPasswordScreen(email: Get.parameters['email'] ?? ''),
    ),
   GetPage(name: RRoutes.dashboard, page: () => const DashboardScreen(), middlewares: [RRrouteMiddleware()]),
   GetPage(name: RRoutes.media, page: () => const MediaScreen(), middlewares: [RRrouteMiddleware()]),


   // Categories
    GetPage(name: RRoutes.categories, page: () => const CategoriesScreen(), middlewares: [RRrouteMiddleware()]),
    GetPage(name: RRoutes.createCategory, page: () => const CreateCategoriesScreen(), middlewares: [RRrouteMiddleware()]),
    GetPage(name: RRoutes.editCategory, page: () => const EditCategoriesScreen(), middlewares: [RRrouteMiddleware()]),


    // Brands 
     GetPage(name: RRoutes.brands, page: () => const BrandScreen(), middlewares: [RRrouteMiddleware()]),
     GetPage(name: RRoutes.createBrand, page: () => const CreateBrandScreen(), middlewares: [RRrouteMiddleware()]),
     GetPage(name: RRoutes.editBrand, page: () => const EditBrandScreen(), middlewares: [RRrouteMiddleware()]),

     // Banners
     GetPage(name: RRoutes.banners, page: () => const BannerScreen(), middlewares: [RRrouteMiddleware()]),
     GetPage(name: RRoutes.createBanner, page: () => const CreateBannerScreen(), middlewares: [RRrouteMiddleware()]),
     GetPage(name: RRoutes.editBanner, page: () => const EditBannerScreen(), middlewares: [RRrouteMiddleware()]),

     // Products
      GetPage(name: RRoutes.products, page: () => const ProductsScreen(), middlewares: [RRrouteMiddleware()]),
      GetPage(name: RRoutes.createProduct, page: () =>  CreateProductsScreen(), middlewares: [RRrouteMiddleware()]),
      GetPage(name: RRoutes.editProduct, page: () => const EditProductsScreen(), middlewares: [RRrouteMiddleware()]),

      // Customers 
      GetPage(name: RRoutes.customers, page: () => const CustomerScreen(), middlewares: [RRrouteMiddleware()]),
      GetPage(name: RRoutes.customerDetail, page: () => const CustomerDetailScreen(), middlewares: [RRrouteMiddleware()]),

      // Orders
      GetPage(name: RRoutes.orders, page: () => const OrdersScreen(), middlewares: [RRrouteMiddleware()]),
      GetPage(name: RRoutes.orderDetails, page: () => const OrdersDetailScreen(), middlewares: [RRrouteMiddleware()]),

      GetPage(name: RRoutes.settings, page: () => const SettingScreen(), middlewares: [RRrouteMiddleware()]),
      GetPage(name: RRoutes.profile, page: () => const ProfileScreen(), middlewares: [RRrouteMiddleware()]),

  ];
  
}
