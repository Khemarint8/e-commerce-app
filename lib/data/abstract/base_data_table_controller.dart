import 'package:danastoreadminpanel/features/shop/models/category_model.dart';
import 'package:danastoreadminpanel/utils/constants/popups/full_screen_loader.dart';
import 'package:danastoreadminpanel/utils/constants/popups/loaders.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

abstract class TBaseController<T> extends GetxController {
  RxBool isLoading = false.obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;
  RxList<T> allItems = <T>[].obs;
  RxList<T> filteredItems = <T>[].obs;
  RxList<bool> selectedRows = <bool>[].obs;
  final searchTextController = TextEditingController();

   @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  /// Abstract method to be implemented by subclasses for fetching items
  Future<List<T>> fetchItems();

  /// Abstract method to be implemented by subclasses for deleting an item.
  Future<void> deleteItem(T item);

  /// Abstract method to be implemented by subclasses for checking if an item contains the search query
  bool containsSearchQuery(T item, String query);

  /// Common method for fetching data
  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      List<T> fetchedItems = [];
      if (allItems.isEmpty) {
        fetchedItems = await fetchItems();
         print("Fetched ${fetchedItems.length} items.");
      }
      allItems.assignAll(fetchedItems);
      filteredItems.assignAll(allItems);
      selectedRows.assignAll(List.generate(allItems.length, (_) => false));

print("Fetched Items Length: ${fetchedItems.length}");
print("All Items Length: ${allItems.length}");
print("Filtered Items Length: ${filteredItems.length}");

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  /// Common method for searching based on a Query
  void searchQuery(String query) {
    filteredItems.assignAll(
      allItems.where((item) => containsSearchQuery(item, query)));
  }


  /// Common method for sorting items by a property
  void sortByProperty(int sortColumnIndex, bool ascending, Function(T) property) {
    sortAscending.value = ascending;
    this.sortColumnIndex.value = sortColumnIndex;
    filteredItems.sort((a,b) {
      if (ascending) {
        return property(a).compareTo(property(b));
      } else {
        return property(b).compareTo(property(a));
      }
    });
  }


  /// Method for adding an item to the lists.
  void addItemToLists(T item) {
    allItems.add(item);
    filteredItems.add(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false));
  }

  /// Method for updating an item in the lists
  void updateItemFromLists(T item) {
    final itemIndex = allItems.indexWhere((i) => i == item);

    final filteredItemIndex = filteredItems.indexWhere((i) => i == item);

    if (itemIndex != -1) allItems[itemIndex] = item;
    if (filteredItemIndex != -1) filteredItems[itemIndex] = item;
  }


  /// Method for removing an item from the lists.
  void removeItemFromList(T item) {
    allItems.remove(item);
    filteredItems.remove(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false));
  }


  /// Common method for confirming deletion and performing and deletion
  void confirmAndDeleteItem(T item) async {
    // Show a confirmatino dialog
    Get.defaultDialog(
        title: 'Delete Item',
        content: const Text('Are you sure you want to delete this item?'),
        confirm: SizedBox(
          width: 60,
          child: ElevatedButton(
            onPressed: () async => await deleteOnConfirm(item),
            style: OutlinedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(vertical: TSizes.buttonHeight / 2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(TSizes.buttonRadius * 5)),
            ),
            child: const Text('Ok'),
          ),
        ),
        cancel: SizedBox(
          width: 80,
          child: OutlinedButton(
            onPressed: () => Get.back(),
            style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: TSizes.buttonHeight / 2),
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(TSizes.buttonRadius * 5))),
            child: const Text('Cancel'),
          ),
        ));
  }

  /// Method to be implemented by subclasses for handling confirmation before deleting an item
  Future<void> deleteOnConfirm(T item) async {
    try {
      // Remove the COnfirmation Dialog
      TFullScreenLoader.stopLoading();

      // Start the loader
      TFullScreenLoader.popUpCircular();

      // Delete Firestore Data
      await deleteItem(item);

      removeItemFromList(item);
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Item Delete', message: 'Your Item has been Deleted');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

}