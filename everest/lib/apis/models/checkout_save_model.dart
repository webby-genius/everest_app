// To parse this JSON data, do
//
//     final checkOutSaveResponse = checkOutSaveResponseFromJson(jsonString);

import 'dart:convert';

CheckOutSaveResponse checkOutSaveResponseFromJson(String str) => CheckOutSaveResponse.fromJson(json.decode(str));

String checkOutSaveResponseToJson(CheckOutSaveResponse data) => json.encode(data.toJson());

class CheckOutSaveResponse {
    DateTime? lastUpdatedDate;
    int? noOfItems;
    int? totalQty;
    int? subTotal;
    int? totalDiscount;
    int? grandTotal;
    int? vat;
    List<Item>? items;

    CheckOutSaveResponse({
        this.lastUpdatedDate,
        this.noOfItems,
        this.totalQty,
        this.subTotal,
        this.totalDiscount,
        this.grandTotal,
        this.vat,
        this.items,
    });

    factory CheckOutSaveResponse.fromJson(Map<String, dynamic> json) => CheckOutSaveResponse(
        lastUpdatedDate: json["LastUpdatedDate"] == null ? null : DateTime.parse(json["LastUpdatedDate"]),
        noOfItems: json["NoOfItems"],
        totalQty: json["TotalQty"],
        subTotal: json["SubTotal"],
        totalDiscount: json["TotalDiscount"],
        grandTotal: json["GrandTotal"],
        vat: json["VAT"],
        items: json["Items"] == null ? [] : List<Item>.from(json["Items"]!.map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "LastUpdatedDate": lastUpdatedDate?.toIso8601String(),
        "NoOfItems": noOfItems,
        "TotalQty": totalQty,
        "SubTotal": subTotal,
        "TotalDiscount": totalDiscount,
        "GrandTotal": grandTotal,
        "VAT": vat,
        "Items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

class Item {
    String? itemCode;
    String? itemName;
    String? category;
    int? itemId;
    String? pluCode;
    double? salePrice;
    int? categoryId;
    int? itemImage;
    int? quantity;
    int? totalDiscount;
    double? totalPrice;
    String? unit;

    Item({
        this.itemCode,
        this.itemName,
        this.category,
        this.itemId,
        this.pluCode,
        this.salePrice,
        this.categoryId,
        this.itemImage,
        this.quantity,
        this.totalDiscount,
        this.totalPrice,
        this.unit,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        itemCode: json["ItemCode"],
        itemName: json["ItemName"],
        category: json["Category"],
        itemId: json["ItemID"],
        pluCode: json["PLUCode"],
        salePrice: json["SalePrice"]?.toDouble(),
        categoryId: json["CategoryID"],
        itemImage: json["ItemImage"],
        quantity: json["Quantity"],
        totalDiscount: json["TotalDiscount"],
        totalPrice: json["TotalPrice"]?.toDouble(),
        unit: json["Unit"],
    );

    Map<String, dynamic> toJson() => {
        "ItemCode": itemCode,
        "ItemName": itemName,
        "Category": category,
        "ItemID": itemId,
        "PLUCode": pluCode,
        "SalePrice": salePrice,
        "CategoryID": categoryId,
        "ItemImage": itemImage,
        "Quantity": quantity,
        "TotalDiscount": totalDiscount,
        "TotalPrice": totalPrice,
        "Unit": unit,
    };
}
