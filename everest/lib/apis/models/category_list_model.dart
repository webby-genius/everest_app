// To parse this JSON data, do
//
//     final categoryListResponse = categoryListResponseFromJson(jsonString);

import 'dart:convert';

List<CategoryListResponse> categoryListResponseFromJson(String str) => List<CategoryListResponse>.from(json.decode(str).map((x) => CategoryListResponse.fromJson(x)));

String categoryListResponseToJson(List<CategoryListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryListResponse {
    String? categoryName;
    int? categoryId;
    int? categoryImage;

    CategoryListResponse({
        this.categoryName,
        this.categoryId,
        this.categoryImage,
    });

    factory CategoryListResponse.fromJson(Map<String, dynamic> json) => CategoryListResponse(
        categoryName: json["CategoryName"],
        categoryId: json["CategoryID"],
        categoryImage: json["CategoryImage"],
    );

    Map<String, dynamic> toJson() => {
        "CategoryName": categoryName,
        "CategoryID": categoryId,
        "CategoryImage": categoryImage,
    };
}
