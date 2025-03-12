
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universal_html/html.dart';

class ProductCategoryModel {
  final String id; // Add this field
  final String productId;
  final String categoryId;

  ProductCategoryModel({
    this.id = '',  // Include it in the constructor
    required this.productId,
    required this.categoryId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,  // Include this if needed
      'productId': productId,
      'categoryId': categoryId,
    };
  }

  factory ProductCategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ProductCategoryModel(
      id: snapshot.id,  // Assign document ID from Firestore
      productId: data['productId'] as String,
      categoryId: data['categoryId'] as String,
    );
  }
}
