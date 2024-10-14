// To parse this JSON data, do
//
//     final proceedOrderResponse = proceedOrderResponseFromJson(jsonString);

import 'dart:convert';

ProceedOrderResponse proceedOrderResponseFromJson(String str) => ProceedOrderResponse.fromJson(json.decode(str));

String proceedOrderResponseToJson(ProceedOrderResponse data) => json.encode(data.toJson());

class ProceedOrderResponse {
    int? orderId;
    String? message;

    ProceedOrderResponse({
        this.orderId,
        this.message,
    });

    factory ProceedOrderResponse.fromJson(Map<String, dynamic> json) => ProceedOrderResponse(
        orderId: json["OrderID"],
        message: json["Message"],
    );

    Map<String, dynamic> toJson() => {
        "OrderID": orderId,
        "Message": message,
    };
}
