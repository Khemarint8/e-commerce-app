import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:danastoreadminpanel/features/shop/models/banner_model.dart';
import 'package:danastoreadminpanel/utils/constants/exceptions/firebase_exceptions.dart';
import 'package:danastoreadminpanel/utils/constants/exceptions/format_exceptions.dart';
import 'package:danastoreadminpanel/utils/constants/exceptions/platform_exceptions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BannerRepository extends GetxController{
  static BannerRepository get instance => Get.find();

  // Firebase Firestore instance 
  final _db = FirebaseFirestore.instance;

  // Get all banners from Firestore
  Future<List<BannerModel>> getAllBanners() async {
    try{
      final snapshot = await _db.collection('Banners').get();
      final result = snapshot.docs.map((e) => BannerModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong! Please try again.';
    }
  }

  // Create a new banner in Firestore
  Future<String> createBanner(BannerModel banner) async {
    try{
      final result = await _db.collection('Banners').add(banner.toJson());
      return result.id;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Update an existing banner in Firestore
  Future<void> updateBanner(BannerModel banner) async {
    try{
      await _db.collection('Banners').doc(banner.id).update(banner.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Delete a Banner form Firestore
    Future<void> deleteBanner(String bannerId) async {
    try{
      await _db.collection('Banners').doc(bannerId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

}