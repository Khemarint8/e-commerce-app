import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:danastoreadminpanel/features/shop/models/product_category_model.dart';
import 'package:danastoreadminpanel/features/shop/models/product_model.dart';
import 'package:danastoreadminpanel/features/shop/screens/product/create_product/widgets/product_categories.dart';
import 'package:danastoreadminpanel/utils/constants/exceptions/firebase_exceptions.dart';
import 'package:danastoreadminpanel/utils/constants/exceptions/format_exceptions.dart';
import 'package:danastoreadminpanel/utils/constants/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Repository for managin product-related data and operation.
class ProductRepository extends GetxController{
  static ProductRepository get instance => Get.find();

  /// Firestore instance for database interaction.
  final _db = FirebaseFirestore.instance;

  //  Functions


  /// Create product
  Future<String> createProducts(ProductModel product) async {
    try{
      final result = await _db.collection('Products').add(product.toJson());
      return result.id;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  /// Create new product category
  Future<String> createProductsCategory(ProductCategoryModel productCategory) async {
    try{
      final result = await _db.collection('ProductCategory').add(productCategory.toJson());
      return result.id;
    }on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  // Update product
  Future<void> updateProduct(ProductModel product) async {
    try{
      await _db.collection('Products').doc(product.id).update(product.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  // Update Product Instance 
  Future<void> updateProductSpecificValue(id, Map<String, dynamic> data) async {
    try{
      await _db.collection('Products').doc(id).update(data);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Get limited featured products
  Future<List<ProductModel>> getAllProducts() async {
    try{
      final snapshot = await _db.collection('Products').get();
      return snapshot.docs.map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot)).toList();
    }on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  // Get limited features products
  Future<List<ProductCategoryModel>> getProductCategories(String productId) async {
    try{
      final snapshot = await _db.collection('ProductCategory').where('productId', isEqualTo: productId).get();
      return snapshot.docs.map((querySnapshot) => ProductCategoryModel.fromSnapshot(querySnapshot)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  // Delete product
  Future<void> deleteProduct(ProductModel product) async {
    try{
      // Delete all data ta once from Firebase Firestore
      await _db.runTransaction((transaction) async {
        final productRef = _db.collection('Products').doc(product.id);
        final productSnap = await transaction.get(productRef);

        if (!productSnap.exists) {
          throw Exception('Product not found');
        }

        // Fetch ProductCategories
        final productCategoriesSnapshot = await _db.collection('ProductCategory').where('productId', isEqualTo: product.id).get();
        final productCategories = productCategoriesSnapshot.docs.map((e) => ProductCategoryModel.fromSnapshot(e));

        if (productCategories.isNotEmpty) {
          for (var productCategory in productCategories) {
            transaction.delete(_db.collection('ProductCategory').doc(productCategory.id));
          } 
        }

        transaction.delete(productRef);
      });
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Remove product category
  Future<void> removeProductCategory(String productId, String categoryId) async {
    try{
      final result = await _db.collection('ProductCategory').where('productId', isEqualTo: productId).where('categoryId', isEqualTo: categoryId).get();

      for (final doc in result.docs) {
        await doc.reference.delete();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch(e) {
      throw 'Something went wrong. Please try again';
    }
  }
}