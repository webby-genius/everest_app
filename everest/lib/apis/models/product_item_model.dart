// To parse this JSON data, do
//
//     final productItemResponse = productItemResponseFromJson(jsonString);

import 'dart:convert';

List<ProductItemResponse> productItemResponseFromJson(String str) =>
    List<ProductItemResponse>.from(json.decode(str).map((x) => ProductItemResponse.fromJson(x)));

String productItemResponseToJson(List<ProductItemResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductItemResponse {
  String? itemCode;
  String? itemName;
  int? itemId;
  String? pluCode;
  double? salePrice;
  int? itemImage;
  String? category;
  String? unit;
  int? categoryId;

  ProductItemResponse({
    this.itemCode,
    this.itemName,
    this.itemId,
    this.pluCode,
    this.salePrice,
    this.itemImage,
    this.category,
    this.categoryId,
    this.unit,
  });

  factory ProductItemResponse.fromJson(Map<String, dynamic> json) => ProductItemResponse(
        itemCode: json["ItemCode"],
        itemName: json["ItemName"],
        itemId: json["ItemID"],
        pluCode: json["PLUCode"],
        salePrice: json["SalePrice"]?.toDouble(),
        itemImage: json["ItemImage"],
        category: json["Category"],
        categoryId: json["CategoryID"],
        unit: json["Unit"],
      );

  Map<String, dynamic> toJson() => {
        "ItemCode": itemCode,
        "ItemName": itemName,
        "ItemID": itemId,
        "PLUCode": pluCode,
        "SalePrice": salePrice,
        "ItemImage": itemImage,
        "Category": category,
        "CategoryID": categoryId,
        "Unit": unit,
      };
}
