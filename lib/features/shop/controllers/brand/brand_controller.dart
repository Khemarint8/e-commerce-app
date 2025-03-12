import 'package:danastoreadminpanel/data/abstract/base_data_table_controller.dart';
import 'package:danastoreadminpanel/features/shop/controllers/category/category_controller.dart';
import 'package:danastoreadminpanel/features/shop/models/brand_category_model.dart';
import 'package:danastoreadminpanel/features/shop/models/brand_model.dart';
import 'package:danastoreadminpanel/features/shop/repository/brand_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class BrandController extends TBaseController<BrandModel> {
  static BrandController get instance => Get.find();

  final _brandRepository = Get.put(BrandRepository());
  final categoryController = Get.put(CategoryController());

  @override
  bool containsSearchQuery(BrandModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(BrandModel item) async {
    await _brandRepository.deleteBrand(item);
  }

  @override
Future<List<BrandModel>> fetchItems() async {
  final fetchedBrands = await _brandRepository.getAllBrands();
  

  final fetchedBrandCategories = await _brandRepository.getAllBrandCategories();

  if (categoryController.allItems.isNotEmpty)
    await categoryController.fetchItems();

  for (var brand in fetchedBrands) {
    List<String> categoryIds = fetchedBrandCategories
        .where((brandCategory) => brandCategory.brandId == brand.id)
        .map((brandCategory) => brandCategory.categoryId)
        .toList();

    brand.brandCategories = categoryController.allItems.where((category) => categoryIds.contains(category.id)).toList();
  }

  
  return fetchedBrands;
}


  /// Sorting related code
  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(
        sortColumnIndex, ascending, (BrandModel b) => b.name.toLowerCase());
  }

  void sortByParentName(int sortColumnIndex, bool ascending) {
    sortByProperty(
        sortColumnIndex, ascending, (BrandModel b) => b.name.toLowerCase());
  }
}
