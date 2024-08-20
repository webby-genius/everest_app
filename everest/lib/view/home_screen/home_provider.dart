import 'dart:convert';

import 'package:everest/apis/api.dart';
import 'package:everest/apis/api_manager.dart';
import 'package:everest/apis/api_urls.dart';
import 'package:everest/apis/models/product_item_model.dart';
import 'package:everest/widgets/common_toast.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final searchProductController = TextEditingController();

  int _selectCategory = 1;

  // List<String> _categories = ['All', 'Grocery', 'Household'];

  // List<String> get categories => _categories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<ProductItemResponse> _categoryList = [];
  Future productListApiResponse({required BuildContext context}) async {
    isLoading = true;
    try {
      APIResponse response = await APIManager.callAPI(
        context: context,
        url: ApiUrlPage.itemListUrl,
        type: APIMethodType.GET,
      );
      if (response.success) {
        List<ProductItemResponse> productItemResponse = productItemResponseFromJson(json.encode(response.response));
        if (productItemResponse.isNotEmpty) {
          _categoryList = productItemResponse;
          _filteredCategoryList = _categoryList;
          debugPrint("categoryList -->>>> ${_categoryList.length}");
          notifyListeners();
        } else {
          FlutterToastWidget.show("No product found", "error");
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
      debugPrint("ERROR -->> $e");
    }
    notifyListeners();
  }

  List<ProductItemResponse> _filteredCategoryList = [];
  String _selectedCategory = 'All';

  final Map<ProductItemResponse, int> _basket = {};

  HomeProvider() {
    _filteredCategoryList = _categoryList;
    searchProductController.addListener(() {
      filterProducts(searchProductController.text);
    });
    notifyListeners();
  }

  int get selectCategory => _selectCategory;
  set selectCategory(int value) {
    _selectCategory = value;
    notifyListeners();
  }

  // void selectItemCategory(String category) {
  //   _selectedCategory = category;
  //   filterProducts(searchProductController.text);
  // }

  List<ProductItemResponse> get categoryList => _filteredCategoryList;

  Map<ProductItemResponse, int> get basket => _basket;

  // String get selectedCategory => _selectedCategory;
  // set selectedCategory(String value) {
  //   _selectedCategory = value;
  //   filterProducts(searchProductController.text); // Apply filter when category changes
  //   notifyListeners();
  // }

  void addToBasket(ProductItemResponse product) {
    if (_basket.containsKey(product)) {
      _basket[product] = _basket[product]! + 1;
    } else {
      _basket[product] = 1;
    }
    notifyListeners();
  }

  void removeFromBasket(ProductItemResponse product) {
    if (_basket.containsKey(product)) {
      if (_basket[product]! > 1) {
        _basket[product] = _basket[product]! - 1;
      } else {
        _basket.remove(product);
      }
      notifyListeners();
    }
  }

  void filterProducts(String query) {
    List<ProductItemResponse> filteredByQuery =
        _categoryList.where((product) => product.itemName?.toLowerCase().contains(query.toLowerCase()) ?? false).toList();

    if (_selectedCategory != "All") {
      // _filteredCategoryList = filteredByQuery.where((product) => product.categoryType == _selectedCategory).toList();
    } else {
      debugPrint("💪");
      _filteredCategoryList = filteredByQuery;
    }
    // _filteredCategoryList = filteredByQuery;

    notifyListeners();
  }
}

//-=-=-=-=-=-=-=-=-===-=--=-=-=-=----=-=-===-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

// class CategoryResponse {
//   CategoryResponse({
//     this.catImage,
//     this.catName,
//     this.catPrice,
//     this.catSku,
//     this.categoryType,
//   });

//   String? catImage;
//   String? catPrice;
//   String? catName;
//   String? catSku;
//   String? categoryType;
// }

//-=-=-=-=-=-=-=-=-===-=--=-=-=-=----=-=-===-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=