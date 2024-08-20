// To parse this JSON data, do
//
//     final userInfoResponse = userInfoResponseFromJson(jsonString);

import 'dart:convert';

UserInfoResponse userInfoResponseFromJson(String str) => UserInfoResponse.fromJson(json.decode(str));

String userInfoResponseToJson(UserInfoResponse data) => json.encode(data.toJson());

class UserInfoResponse {
    String? businessName;
    String? contactPerson;
    String? addressLine1;
    String? city;
    String? postCode;
    String? telephone;
    String? billingContactPerson;
    String? billingAddressLine1;
    String? billingCity;
    String? billingPostCode;
    String? billingTelephone;

    UserInfoResponse({
        this.businessName,
        this.contactPerson,
        this.addressLine1,
        this.city,
        this.postCode,
        this.telephone,
        this.billingContactPerson,
        this.billingAddressLine1,
        this.billingCity,
        this.billingPostCode,
        this.billingTelephone,
    });

    factory UserInfoResponse.fromJson(Map<String, dynamic> json) => UserInfoResponse(
        businessName: json["BusinessName"],
        contactPerson: json["ContactPerson"],
        addressLine1: json["AddressLine1"],
        city: json["City"],
        postCode: json["PostCode"],
        telephone: json["Telephone"],
        billingContactPerson: json["BillingContactPerson"],
        billingAddressLine1: json["BillingAddressLine1"],
        billingCity: json["BillingCity"],
        billingPostCode: json["BillingPostCode"],
        billingTelephone: json["BillingTelephone"],
    );

    Map<String, dynamic> toJson() => {
        "BusinessName": businessName,
        "ContactPerson": contactPerson,
        "AddressLine1": addressLine1,
        "City": city,
        "PostCode": postCode,
        "Telephone": telephone,
        "BillingContactPerson": billingContactPerson,
        "BillingAddressLine1": billingAddressLine1,
        "BillingCity": billingCity,
        "BillingPostCode": billingPostCode,
        "BillingTelephone": billingTelephone,
    };
}
