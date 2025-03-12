import 'package:danastoreadminpanel/features/shop/controllers/product/product_variation_controller.dart';
import 'package:danastoreadminpanel/features/shop/models/product_attribute_model.dart';
import 'package:danastoreadminpanel/utils/constants/popups/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductAttributeController extends GetxController{
  static ProductAttributeController get instance => Get.find();

  // Observables for loading state, form key, and product attributes
  final isLoading = false.obs;
  final attributesFormKey = GlobalKey<FormState>();
  TextEditingController attributeName = TextEditingController();
  TextEditingController attributes = TextEditingController();
  final RxList<ProductAttributeModel> productAttributes = <ProductAttributeModel>[].obs;

  // Function to add a new attribute
  void addNewAttirbutes() {
    // Form Validation
    if (!attributesFormKey.currentState!.validate()) {
      return;
    }

    // Add Attributes to the List of Attributes
    productAttributes.add(ProductAttributeModel(name: attributeName.text.trim(), values: attributes.text.trim().split('|').toList()));

    // Clear text fields after adding
    attributeName.text = '';
    attributes.text = '';
  }

  // Function to remove an attribute
  void removeAttribute(int index, BuildContext context) {
    // SHow a confirmation dialog
    TDialogs.defaultDialog(context: context, onConfirm: () {
      // User confirmed, remove the atributed
      Navigator.of(context).pop();
      productAttributes.removeAt(index);

      // Reset productVariation when removing an attribute
      ProductVariationController.instance.productVariation.value = [];
    });
  }

  // Function to reset productAttribute
  void resetProductAttribute() {
    productAttributes.clear();
  }
}