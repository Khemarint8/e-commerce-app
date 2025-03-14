import 'package:danastoreadminpanel/data/abstract/base_data_table_controller.dart';
import 'package:danastoreadminpanel/features/shop/models/banner_model.dart';
import 'package:danastoreadminpanel/features/shop/repository/banner_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class BannerController extends TBaseController<BannerModel>{
  static BannerController get instance => Get.find();

  final _bannerRepository = Get.put(BannerRepository());

  @override
  bool containsSearchQuery(BannerModel item, String query) {
    return false;
  }

  @override
  Future<void> deleteItem(BannerModel item) async {
    await _bannerRepository.deleteBanner(item.id ?? '');
  }

  @override
  Future<List<BannerModel>> fetchItems() async {
    return await _bannerRepository.getAllBanners();
  }

  // Method for formatting a route string
  String formatRoute(String route) {
    if (route.isEmpty) return '';
    // Remove the leading '/'
    String formatted = route.substring(1);

    // Capitalize the first character 
    formatted = formatted[0].toUpperCase() + formatted.substring(1);

    return formatted;
  }
  
}