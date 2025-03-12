// import 'package:danastoreadminpanel/features/shop/controllers/category/category_controller.dart';
// import 'package:danastoreadminpanel/features/shop/controllers/product/product_attribute_controller.dart';
// import 'package:danastoreadminpanel/features/shop/controllers/product/product_controller.dart';
// import 'package:danastoreadminpanel/features/shop/controllers/product/product_images_controller.dart';
// import 'package:danastoreadminpanel/features/shop/controllers/product/product_variation_controller.dart';
// import 'package:danastoreadminpanel/features/shop/models/brand_model.dart';
// import 'package:danastoreadminpanel/features/shop/models/category_model.dart';
// import 'package:danastoreadminpanel/features/shop/models/product_category_model.dart';
// import 'package:danastoreadminpanel/features/shop/models/product_model.dart';
// import 'package:danastoreadminpanel/features/shop/repository/product_repository.dart';
// import 'package:danastoreadminpanel/features/shop/screens/product/create_product/widgets/product_categories.dart';
// import 'package:danastoreadminpanel/utils/constants/enums.dart';
// import 'package:danastoreadminpanel/utils/constants/helpers/network_manager.dart';
// import 'package:danastoreadminpanel/utils/constants/image_strings.dart';
// import 'package:danastoreadminpanel/utils/constants/popups/full_screen_loader.dart';
// import 'package:danastoreadminpanel/utils/constants/popups/loaders.dart';
// import 'package:danastoreadminpanel/utils/constants/sizes.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';

// class EditProductController extends GetxController{
//   // Singleton instance
//   static EditProductController get instance => Get.find();
  
//   // Observables for loading state and product details
//   final isLoading = false.obs;
//   final selectedCategoriesLoader = false.obs;
//   final productType = ProductType.single.obs;
//   final productVisibility = ProductVisibility.hidden.obs;

//   // Controllers and keys
//   final variationConttroller = Get.put(ProductVariationController());
//   final attributeController = Get.put(ProductAttributeController());
//   final imagesController = Get.put(ProductImagesController());
//   final productRepository = Get.put(ProductRepository());
//   final stockPriceFormkey = GlobalKey<FormState>();
//   final titleDescriptionFormKey = GlobalKey<FormState>();


//   // Text editing controllers for input fields
//   TextEditingController title = TextEditingController();
//   TextEditingController description = TextEditingController();
//   TextEditingController stock = TextEditingController();
//   TextEditingController price = TextEditingController();
//   TextEditingController salePrice = TextEditingController();
//   TextEditingController brandTextField = TextEditingController();

//   // Rx observables for selected brand and categories
//   final Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
//   final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;
//    final List<CategoryModel> alreadyAddedCategories = <CategoryModel>[];

//    // Flags for tracking different tasks
//    RxBool thumbnailUploader = true.obs;
//    RxBool productDataUploader = false.obs;
//    RxBool additionalImageUploader = true.obs;
//    RxBool categoriesRelationshipUploader = false.obs;

//    // Initialize Product Data
//    void initProductData(ProductModel product) {
//     try{
//       isLoading.value = true;

//       // Basic Information
//       title.text = product.title;
//       description.text = product.description ?? '';
//       productType.value = product.productType == ProductType.single.toString() ? ProductType.single : ProductType.variable;

//       // Stock & Pricing (assuming productType and productVisibility are handles elsewhere)

//       if (product.productType == ProductType.single.toString()) {
//         stock.text = product.stock.toString();
//         price.text = product.price.toString();
//         salePrice.text = product.salePrice.toString();
//       }

//       // Products Brand
//       selectedBrand.value = product.brand;
//       brandTextField.text = product.brand?.name ?? '';

//       // Product Thumbnail and Images
//       if (product.images != null) {
//         // Set the first image as the thumnail
//         imagesController.selectedThumbnailImageUrl.value = product.thumbnail;

//         // Add the images to additionalProductImagesUrl
//         imagesController.additionalProductImagesUrls.assignAll(product.images ?? []);
//       }

//       // Product attributes & variations (assuming you have a method to fetch variations in ProductVariationController)
//       attributeController.productAttributes.assignAll(product.productAttributes ?? []);
//       variationConttroller.productVariation.assignAll(product.productVariation ?? []);
//       variationConttroller.initializeVariationControllers(product.productVariation ?? []);

//       isLoading.value = false;

//       update();
//     } catch (e) {
//       if (kDebugMode) print(e);
//     }
//    }

//    Future<List<CategoryModel>> loadSelectedCategories(String productId) async {
//     selectedCategoriesLoader.value = true;
//     // Product Categories
//     final productCategories = await productRepository.getProductCategories(productId);
//     final categoriesController = Get.put(CategoryController());
//     if (categoriesController.allItems.isEmpty) await categoriesController.fetchItems();

//     final categoriesIds = productCategories.map((e) => e.categoryId).toList();
//     final categories = categoriesController.allItems.where((element) => categoriesIds.contains(element.id)).toList();
//     selectedCategories.assignAll(categories);
//     alreadyAddedCategories.assignAll(categories);
//     selectedCategoriesLoader.value = false;
//     return categories;
//    }

//    // Function to create a new product
//    Future<void> editProduct(ProductModel product) async {
//     try{
//       // Show progress dialog
//       // Start Loading
//       TFullScreenLoader.popUpCircular();

//       // Check Internet Connectivity
//       final isConnected = await NetworkManager.instance.isConnected();
//       if (!isConnected) {
//         TFullScreenLoader.stopLoading();
//         return;
//       }

//       // Validate title and description form
//       if (!titleDescriptionFormKey.currentState!.validate()) {
//         TFullScreenLoader.stopLoading();
//         return;
//       }

//       // Validate stock and pricing from if ProductType = Single
//       if (productType.value == ProductType.single && !stockPriceFormkey.currentState!.validate()) {
//         TFullScreenLoader.stopLoading();
//         return;
//       }

//       // Ensure a brand is selected
//       if (selectedBrand.value == null) throw 'Select Brand for this product';

//       // Check variation data if ProductType = variable
//       if (productType.value == ProductType.variable && ProductVariationController.instance.productVariation.isEmpty) {
//         throw 'There are no variations for the Product Type Variable. Create some variation or change Product Type.';
//       }

//       if (productType.value == ProductType.variable) {
//         final variationCheckFailed = ProductVariationController.instance.productVariation.any((element) => element.price.isNaN || element.price < 0 || element.salePrice.isNaN || element.salePrice < 0 || element.stock.isNaN || element.stock < 0);

//         if (variationCheckFailed) throw 'Variation data is not accurate. Please recheck variations';
//       }

//       // Upload Product Thumbnail Image
//       final imagesController = ProductImagesController.instance;
//       if (imagesController.selectedThumbnailImageUrl.value == null || imagesController.selectedThumbnailImageUrl.value!.isEmpty){
//         throw 'Upload Product Thumbnail Image';
//       }

//       // Upload Product Variation Images if any
//       var variations = ProductVariationController.instance.productVariation;
//       if(productType.value == ProductType.single && variations.isNotEmpty) {
//         // If admin added variations and then changed the product Type, remove all varaitons
//         ProductVariationController.instance.resetAllValues();
//         variations.value = [];
//       }

//       product.sku = '';
//       product.isFeatured = true;
//       product.title = title.text.trim();
//       product.brand = selectedBrand.value;
//       product.description = description.text.trim();
//       product.productType = productType.value.toString();
//       product.stock = int.tryParse(stock.text.trim()) ?? 0;
//       product.price = double.tryParse(price.text.trim()) ?? 0;
//       product.images = imagesController.additionalProductImagesUrls;
//       product.salePrice = double.tryParse(salePrice.text.trim()) ?? 0;
//       product.thumbnail = imagesController.selectedThumbnailImageUrl.value ?? '';
//       product.productAttributes = ProductAttributeController.instance.productAttributes;
//       product.productVariation = variations;

//       // Call Repository to UpdateNew Product
//       productDataUploader.value = true;
//       await ProductRepository.instance.updateProduct(product);

//       // Register product categories if any
//       if (selectedCategories.isNotEmpty) {
//         // Loop through selected Product categories
//         categoriesRelationshipUploader.value = true;

//         // Get the existing category IDs
//         List<String> existingCategoryIds = alreadyAddedCategories.map((category) => category.id).toList();

//         for (var category in selectedCategories) {
//           // Check if the category is not already associated with the product
//           if (!existingCategoryIds.contains(category.id)) {
//             // Map Data
//             final productCategory = ProductCategoryModel(productId: product.id, categoryId: category.id);
//             await ProductRepository.instance.createProductsCategory(productCategory); 
//           }
//         }

//         // Remove categories not selected by the user
//         for (var existingCategoryId in existingCategoryIds) {
//           // Check if the category is not already associated with the product
//           if (!selectedCategories.any((category) => category.id == existingCategoryId)) {
//             // Remove the association
//             await ProductRepository.instance.removeProductCategory(product.id, existingCategoryId);
//           }
//         }
//       }

//       // Update Product List
//       ProductController.instance.updateItemFromLists(product);

//       // Reset Form Values
//       // resetValues();

//       // Close the Progress Loader
//       TFullScreenLoader.stopLoading();

//       // Show Success Message Loader
//       showCompletionDialog();

//     } catch (e) {
//       TFullScreenLoader.stopLoading();
//       TLoaders.errorSnackBar(title: 'On Snap', message: e.toString());
//     }
//    }


//    // show completion dialog
//   void showCompletionDialog() {
//     Get.dialog(AlertDialog(
//       title: const Text('Congratulation'),
//       actions: [
//         TextButton(
//             onPressed: () {
//               Get.back();
//             },
//             child: const Text('Go to Products'))
//       ],
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Image.asset(TImages.productsIllustration, height: 200, width: 200),
//           const SizedBox(height: TSizes.spaceBtwItems),
//           Text('Congratulations',
//               style: Theme.of(Get.context!).textTheme.headlineSmall),
//           const SizedBox(height: TSizes.spaceBtwItems),
//           const Text('Your Product has been Updated'),
//         ],
//       ),
//     ));
//   }
// }