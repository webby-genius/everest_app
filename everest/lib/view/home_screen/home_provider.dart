import 'package:everest/utils/assets.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final searchProductController = TextEditingController();

  int _selectCategory = 1;

  int get selectCategory => _selectCategory;
  set selectCategory(int value) {
    _selectCategory = value;
    notifyListeners();
  }

  List<CategoryResponse> categoryList = [
    CategoryResponse(catName: "Shower Gel Africa ", catImage: PngValues.flamaImg, catPrice: "£13", catSku: "12345"),
    CategoryResponse(catName: "Shower Gel Africa Show", catImage: PngValues.coolKickImg, catPrice: "£10", catSku: "23456"),
    CategoryResponse(catName: "Shower Gel Africa ", catImage: PngValues.flamaImg, catPrice: "£15", catSku: "12345"),
    CategoryResponse(catName: "Shower Gel Africa Show", catImage: PngValues.coolKickImg, catPrice: "£30", catSku: "37645"),
    CategoryResponse(catName: "Shower Gel Africa ", catImage: PngValues.flamaImg, catPrice: "£10", catSku: "12765"),
    CategoryResponse(catName: "Shower Gel Africa Show", catImage: PngValues.coolKickImg, catPrice: "£20", catSku: "13345"),
    CategoryResponse(catName: "Shower Gel Africa ", catImage: PngValues.coolKickImg, catPrice: "£25", catSku: "12345"),
    CategoryResponse(catName: "Shower Gel Africa Show", catImage: PngValues.flamaImg, catPrice: "£10", catSku: "12765"),
    CategoryResponse(catName: "Shower Gel Africa ", catImage: PngValues.flamaImg, catPrice: "£50", catSku: "12345"),
    CategoryResponse(catName: "Shower Gel Africa Show", catImage: PngValues.flamaImg, catPrice: "£5", catSku: "14745"),
    CategoryResponse(catName: "Shower Gel Africa ", catImage: PngValues.flamaImg, catPrice: "£10", catSku: "12835"),
  ];

  // Basket to store product and their quantities
  final Map<CategoryResponse, int> _basket = {};

  Map<CategoryResponse, int> get basket => _basket;

  void addToBasket(CategoryResponse product) {
    if (_basket.containsKey(product)) {
      _basket[product] = _basket[product]! + 1;
    } else {
      _basket[product] = 1;
    }
    notifyListeners();
  }

  void removeFromBasket(CategoryResponse product) {
    if (_basket.containsKey(product)) {
      if (_basket[product]! > 1) {
        _basket[product] = _basket[product]! - 1;
      } else {
        _basket.remove(product);
      }
      notifyListeners();
    }
  }
}

class CategoryResponse {
  CategoryResponse({
    this.catImage,
    this.catName,
    this.catPrice,
    this.catSku,
  });
  String? catImage;
  String? catPrice;
  String? catName;
  String? catSku;
}
