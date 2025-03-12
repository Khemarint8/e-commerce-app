import 'dart:io';
import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:danastoreadminpanel/features/shop/models/brand_category_model.dart';
import 'package:danastoreadminpanel/features/shop/models/brand_model.dart';
import 'package:danastoreadminpanel/utils/constants/exceptions/firebase_exceptions.dart';
import 'package:danastoreadminpanel/utils/constants/exceptions/format_exceptions.dart';
import 'package:danastoreadminpanel/utils/constants/exceptions/platform_exceptions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get all brands from the 'Brands' collection
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection('Brands').get();
      return snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw e.message ?? 'Firebase error occurred!';
    } on SocketException catch (_) {
      throw 'No internet connection! Please check your network.';
    } on PlatformException catch (e) {
      throw e.message ?? 'Platform error occurred!';
    } catch (e) {
      throw 'Something went wrong! Please try again.';
    }
  }

  // Get Brands for Category
  Future<List<BrandCategoryModel>> getAllBrandCategories() async {
    try {
      final snapshot = await _db.collection('BrandCategory').get();
      return snapshot.docs
          .map((doc) => BrandCategoryModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw e.message ?? 'Firebase error occurred!';
    } on SocketException catch (_) {
      throw 'No internet connection! Please check your network.';
    } on PlatformException catch (e) {
      throw e.message ?? 'Platform error occurred!';
    } catch (e) {
      throw 'Something went wrong! Please try again.';
    }
  }

  // Get specific brand categories for a given brand 10
  Future<List<BrandCategoryModel>> getCategoriesOfSpecificBrand(
      String brandId) async {
    try {
      final brandCategoryQuery = await _db
          .collection('BrandCategory')
          .where('brandId', isEqualTo: brandId)
          .get();
      final brandCategories = brandCategoryQuery.docs
          .map((doc) => BrandCategoryModel.fromSnapshot(doc))
          .toList();
      return brandCategories;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something Went Wrong! Please try again.';
    }
  }

  // Create a new brand document in the 'Brands' collection
  Future<String> createBrand(BrandModel brand) async {
    try {
      final result = await _db.collection('Brands').add(brand.toJson());
      return result.id;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  // Create a new brand category  document in the 'BrandCategory' collection
  Future<String> createBrandCategory(BrandCategoryModel brandCategories) async {
    try{
      final result = await _db.collection('BrandCategory').add(brandCategories.toJson());
      return result.id;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
     throw 'Something went wrong, Please try again';
    }
  }

  Future<void> updateBrand(BrandModel brand) async {
    try{
      await _db.collection('Brands').doc(brand.id).update(brand.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }


  // Delete an existing brand document and its associated brand categories
  Future<void> deleteBrand(BrandModel brand) async {
    try{
      await _db.runTransaction((transaction) async {
        final brandRef = _db.collection('Brands').doc(brand.id);
        final brandSnap = await transaction.get(brandRef);

        if (!brandSnap.exists) {
          throw Exception('Brand not Found');
        }

        final brandCategoriesSnapshot = await _db.collection('BrandCategory').where('brandId', isEqualTo: brand.id).get();
        final brandCategories = brandCategoriesSnapshot.docs.map((e) => BrandCategoryModel.fromSnapshot(e));

        if (brandCategories.isNotEmpty) {
          for (var brandCategory in brandCategories) {
            transaction.delete(_db.collection('BrandCategory').doc(brandCategory.id));
          }
        }

        transaction.delete(brandRef);

      });
    }on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  // Delete a brand category document in the 'BrandCategory' collection 
  Future<void> deleteBrandCategory(String brandCategoryId) async {
    try{
      await _db.collection('BrandCategory').doc(brandCategoryId).delete();
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
}
