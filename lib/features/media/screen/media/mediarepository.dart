import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:danastoreadminpanel/features/shop/models/image_model.dart';
import 'package:danastoreadminpanel/utils/constants/enums.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;

class MediaRepository extends GetxController {
  static MediaRepository get instance => Get.find();

  // Firebase Storage instance
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload any Image using File
  Future<ImageModel> uploadImageFileInStorage(
      {required html.File file,
      required String path,
      required String imageName}) async {
    try {
      // Reference to the storage location
      final Reference ref = _storage.ref('$path/$imageName');
      // Upload file
      await ref.putBlob(file);

      // Get download URL
      final String downloadURL = await ref.getDownloadURL();

      // Fetch metadata
      final FullMetadata metadata = await ref.getMetadata();

      return ImageModel.fromFirebaseMetadata(
          metadata, path, imageName, downloadURL);
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  /// Upload Image data in Firestore
  Future<String> uploadImageFileInDatabase(ImageModel image) async {
    try {
      final data = await FirebaseFirestore.instance
          .collection('Images')
          .add(image.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  // Fetch images form Firestore based on media category and load count
  Future<List<ImageModel>> fetchImagesFromDatabase(
      MediaCategory mediaCategory, int loadCount) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Images')
          .where('mediaCategory', isEqualTo: mediaCategory.name.toString())
          .orderBy('createdAt', descending: true)
          .limit(loadCount)
          .get();

      return querySnapshot.docs.map((e) => ImageModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  //Load more images from Firestore based on media category, load count, and last fetched date
  Future<List<ImageModel>> loadMoreImagesFromDatabase(
      MediaCategory mediaCategory,
      int loadCount,
      DateTime lastFetchedData) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Images')
          .where('mediaCategory', isEqualTo: mediaCategory.name.toString())
          .orderBy('createdAt', descending: true)
          .startAfter([lastFetchedData])
          .limit(loadCount)
          .get();

      return querySnapshot.docs.map((e) => ImageModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }


  // Delete file from Firebase Storage and corresponding document from FIrestore
  Future<void> deleteFileFromStorage(ImageModel image) async {
    try{
      await FirebaseStorage.instance.refFromURL(image.url).delete();
      await FirebaseFirestore.instance.collection('Images').doc(image.id).delete();
    } on FirebaseException catch(e) {
      throw e.message ?? 'Something went wrong while deleting image.';
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
}
