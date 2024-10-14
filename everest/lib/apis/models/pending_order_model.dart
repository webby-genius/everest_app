// To parse this JSON data, do
//
//     final pendingOrderResponse = pendingOrderResponseFromJson(jsonString);

import 'dart:convert';

List<PendingOrderResponse> pendingOrderResponseFromJson(String str) => List<PendingOrderResponse>.from(json.decode(str).map((x) => PendingOrderResponse.fromJson(x)));

String pendingOrderResponseToJson(List<PendingOrderResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PendingOrderResponse {
    dynamic invoiceDraftId;
    dynamic invoiceDraftNo;
    int? invoiceId;
    int? invoiceTypeId;
    String? invoiceType;
    String? invoiceNo;
    int? orderTypeId;
    String? orderType;
    String? invoiceStatus;
    int? userId;
    String? username;
    String? department;
    int? departmentId;
    int? customerId;
    dynamic customerAreaId;
    dynamic customerArea;
    Customer? customer;
    SalesRep? salesRep;
    dynamic terminal;
    int? terminalId;
    dynamic user;
    dynamic salesRepId;
    int? creditDays;
    DateTime? invoiceDate;
    int? age;
    double? subTotal;
    double? estimatedProfit;
    int? noOfItems;
    dynamic? noOfQty;
    dynamic? averageItemManualDiscountPerc;
    dynamic? itemDiscount;
    dynamic? itemManualDiscount;
    dynamic? cashierDiscount;
    dynamic cashierDiscountPerc;
    dynamic? totalDiscount;
    dynamic? totalCost;
    dynamic itemVat;
    dynamic invoiceVat;
    dynamic totalVat;
    double? totalAmount;
    double? dueAmount;
    dynamic? paidAmount;
    dynamic? postAdjustment;
    dynamic noteToCustomer;
    dynamic customerName;
    dynamic privateNote;
    bool? isCancelled;
    String? getStatus;
    dynamic cancelledBy;
    dynamic cancelledDate;
    dynamic createdBy;
    dynamic createdDate;
    dynamic updatedBy;
    dynamic updatedDate;
    String? referenceNo;
    dynamic invoiceDetails;
    dynamic invoiceReturnDetails;
    dynamic invoicePaymentDetails;
    dynamic invoicePaymentAdjustmentDetails;
    dynamic invoiceAdjustments;
    dynamic invoicePaymentAdjustmentReturnDetails;
    dynamic? totalCostForSales;
    dynamic? totalCostForReturns;
    dynamic? totalDiscountForReturns;
    dynamic? totalDiscountForSales;
    dynamic? totalSalesAmount;
    dynamic? receivableSalesAmount;
    dynamic? totalSalesReturnAmount;
    dynamic? receivableReturnAmount;

    PendingOrderResponse({
        this.invoiceDraftId,
        this.invoiceDraftNo,
        this.invoiceId,
        this.invoiceTypeId,
        this.invoiceType,
        this.invoiceNo,
        this.orderTypeId,
        this.orderType,
        this.invoiceStatus,
        this.userId,
        this.username,
        this.department,
        this.departmentId,
        this.customerId,
        this.customerAreaId,
        this.customerArea,
        this.customer,
        this.salesRep,
        this.terminal,
        this.terminalId,
        this.user,
        this.salesRepId,
        this.creditDays,
        this.invoiceDate,
        this.age,
        this.subTotal,
        this.estimatedProfit,
        this.noOfItems,
        this.noOfQty,
        this.averageItemManualDiscountPerc,
        this.itemDiscount,
        this.itemManualDiscount,
        this.cashierDiscount,
        this.cashierDiscountPerc,
        this.totalDiscount,
        this.totalCost,
        this.itemVat,
        this.invoiceVat,
        this.totalVat,
        this.totalAmount,
        this.dueAmount,
        this.paidAmount,
        this.postAdjustment,
        this.noteToCustomer,
        this.customerName,
        this.privateNote,
        this.isCancelled,
        this.getStatus,
        this.cancelledBy,
        this.cancelledDate,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate,
        this.referenceNo,
        this.invoiceDetails,
        this.invoiceReturnDetails,
        this.invoicePaymentDetails,
        this.invoicePaymentAdjustmentDetails,
        this.invoiceAdjustments,
        this.invoicePaymentAdjustmentReturnDetails,
        this.totalCostForSales,
        this.totalCostForReturns,
        this.totalDiscountForReturns,
        this.totalDiscountForSales,
        this.totalSalesAmount,
        this.receivableSalesAmount,
        this.totalSalesReturnAmount,
        this.receivableReturnAmount,
    });

    factory PendingOrderResponse.fromJson(Map<String, dynamic> json) => PendingOrderResponse(
        invoiceDraftId: json["InvoiceDraftID"],
        invoiceDraftNo: json["InvoiceDraftNo"],
        invoiceId: json["InvoiceID"],
        invoiceTypeId: json["InvoiceTypeID"],
        invoiceType: json["InvoiceType"],
        invoiceNo: json["InvoiceNo"],
        orderTypeId: json["OrderTypeID"],
        orderType: json["OrderType"],
        invoiceStatus: json["InvoiceStatus"],
        userId: json["UserID"],
        username: json["Username"],
        department: json["Department"],
        departmentId: json["DepartmentID"],
        customerId: json["CustomerID"],
        customerAreaId: json["CustomerAreaID"],
        customerArea: json["CustomerArea"],
        customer: json["Customer"] == null ? null : Customer.fromJson(json["Customer"]),
        salesRep: json["SalesRep"] == null ? null : SalesRep.fromJson(json["SalesRep"]),
        terminal: json["Terminal"],
        terminalId: json["TerminalID"],
        user: json["User"],
        salesRepId: json["SalesRepID"],
        creditDays: json["CreditDays"],
        invoiceDate: json["InvoiceDate"] == null ? null : DateTime.parse(json["InvoiceDate"]),
        age: json["Age"],
        subTotal: json["SubTotal"]?.toDouble(),
        estimatedProfit: json["EstimatedProfit"]?.toDouble(),
        noOfItems: json["NoOfItems"],
        noOfQty: json["NoOfQty"],
        averageItemManualDiscountPerc: json["AverageItemManualDiscountPerc"],
        itemDiscount: json["ItemDiscount"],
        itemManualDiscount: json["ItemManualDiscount"],
        cashierDiscount: json["CashierDiscount"],
        cashierDiscountPerc: json["CashierDiscountPerc"],
        totalDiscount: json["TotalDiscount"],
        totalCost: json["TotalCost"],
        itemVat: json["ItemVAT"],
        invoiceVat: json["InvoiceVAT"],
        totalVat: json["TotalVAT"],
        totalAmount: json["TotalAmount"]?.toDouble(),
        dueAmount: json["DueAmount"]?.toDouble(),
        paidAmount: json["PaidAmount"],
        postAdjustment: json["PostAdjustment"],
        noteToCustomer: json["NoteToCustomer"],
        customerName: json["CustomerName"],
        privateNote: json["PrivateNote"],
        isCancelled: json["IsCancelled"],
        getStatus: json["GetStatus"],
        cancelledBy: json["CancelledBy"],
        cancelledDate: json["CancelledDate"],
        createdBy: json["CreatedBy"],
        createdDate: json["CreatedDate"],
        updatedBy: json["UpdatedBy"],
        updatedDate: json["UpdatedDate"],
        referenceNo: json["ReferenceNo"],
        invoiceDetails: json["InvoiceDetails"],
        invoiceReturnDetails: json["InvoiceReturnDetails"],
        invoicePaymentDetails: json["InvoicePaymentDetails"],
        invoicePaymentAdjustmentDetails: json["InvoicePaymentAdjustmentDetails"],
        invoiceAdjustments: json["InvoiceAdjustments"],
        invoicePaymentAdjustmentReturnDetails: json["InvoicePaymentAdjustmentReturnDetails"],
        totalCostForSales: json["TotalCostForSales"],
        totalCostForReturns: json["TotalCostForReturns"],
        totalDiscountForReturns: json["TotalDiscountForReturns"],
        totalDiscountForSales: json["TotalDiscountForSales"],
        totalSalesAmount: json["TotalSalesAmount"],
        receivableSalesAmount: json["ReceivableSalesAmount"],
        totalSalesReturnAmount: json["TotalSalesReturnAmount"],
        receivableReturnAmount: json["ReceivableReturnAmount"],
    );

    Map<String, dynamic> toJson() => {
        "InvoiceDraftID": invoiceDraftId,
        "InvoiceDraftNo": invoiceDraftNo,
        "InvoiceID": invoiceId,
        "InvoiceTypeID": invoiceTypeId,
        "InvoiceType": invoiceType,
        "InvoiceNo": invoiceNo,
        "OrderTypeID": orderTypeId,
        "OrderType": orderType,
        "InvoiceStatus": invoiceStatus,
        "UserID": userId,
        "Username": username,
        "Department": department,
        "DepartmentID": departmentId,
        "CustomerID": customerId,
        "CustomerAreaID": customerAreaId,
        "CustomerArea": customerArea,
        "Customer": customer?.toJson(),
        "SalesRep": salesRep?.toJson(),
        "Terminal": terminal,
        "TerminalID": terminalId,
        "User": user,
        "SalesRepID": salesRepId,
        "CreditDays": creditDays,
        "InvoiceDate": invoiceDate?.toIso8601String(),
        "Age": age,
        "SubTotal": subTotal,
        "EstimatedProfit": estimatedProfit,
        "NoOfItems": noOfItems,
        "NoOfQty": noOfQty,
        "AverageItemManualDiscountPerc": averageItemManualDiscountPerc,
        "ItemDiscount": itemDiscount,
        "ItemManualDiscount": itemManualDiscount,
        "CashierDiscount": cashierDiscount,
        "CashierDiscountPerc": cashierDiscountPerc,
        "TotalDiscount": totalDiscount,
        "TotalCost": totalCost,
        "ItemVAT": itemVat,
        "InvoiceVAT": invoiceVat,
        "TotalVAT": totalVat,
        "TotalAmount": totalAmount,
        "DueAmount": dueAmount,
        "PaidAmount": paidAmount,
        "PostAdjustment": postAdjustment,
        "NoteToCustomer": noteToCustomer,
        "CustomerName": customerName,
        "PrivateNote": privateNote,
        "IsCancelled": isCancelled,
        "GetStatus": getStatus,
        "CancelledBy": cancelledBy,
        "CancelledDate": cancelledDate,
        "CreatedBy": createdBy,
        "CreatedDate": createdDate,
        "UpdatedBy": updatedBy,
        "UpdatedDate": updatedDate,
        "ReferenceNo": referenceNo,
        "InvoiceDetails": invoiceDetails,
        "InvoiceReturnDetails": invoiceReturnDetails,
        "InvoicePaymentDetails": invoicePaymentDetails,
        "InvoicePaymentAdjustmentDetails": invoicePaymentAdjustmentDetails,
        "InvoiceAdjustments": invoiceAdjustments,
        "InvoicePaymentAdjustmentReturnDetails": invoicePaymentAdjustmentReturnDetails,
        "TotalCostForSales": totalCostForSales,
        "TotalCostForReturns": totalCostForReturns,
        "TotalDiscountForReturns": totalDiscountForReturns,
        "TotalDiscountForSales": totalDiscountForSales,
        "TotalSalesAmount": totalSalesAmount,
        "ReceivableSalesAmount": receivableSalesAmount,
        "TotalSalesReturnAmount": totalSalesReturnAmount,
        "ReceivableReturnAmount": receivableReturnAmount,
    };
}

class Customer {
    bool? isAddNew;
    int? customerId;
    String? customerNo;
    String? customerName;
    String? addressLine1;
    String? addressLine2;
    String? addressLine3;
    dynamic city;
    dynamic cityId;
    dynamic customerArea;
    dynamic customerAreaId;
    dynamic email;
    dynamic telephoneNo;
    dynamic mobileNo;
    dynamic? creditLimit;
    dynamic? currentBalance;
    int? creditDays;
    bool? isActive;
    bool? isDeleted;
    int? departmentId;
    dynamic createdBy;
    dynamic createdDate;
    dynamic updatedBy;
    dynamic updatedDate;
    dynamic otherName;
    dynamic? openingBalance;
    dynamic note;
    dynamic customerTitleId;
    dynamic idNo;
    dynamic? unrealizedChequeTotal;
    dynamic? returnedChequeTotal;
    dynamic telephoneNo2;
    dynamic vatRegNo;
    dynamic companyRegNo;
    dynamic eoid;
    dynamic fid;
    dynamic entity;
    dynamic typeOfBusiness;
    bool? subs;
    bool? restricted;
    int? customerTypeId;
    dynamic customerType;

    Customer({
        this.isAddNew,
        this.customerId,
        this.customerNo,
        this.customerName,
        this.addressLine1,
        this.addressLine2,
        this.addressLine3,
        this.city,
        this.cityId,
        this.customerArea,
        this.customerAreaId,
        this.email,
        this.telephoneNo,
        this.mobileNo,
        this.creditLimit,
        this.currentBalance,
        this.creditDays,
        this.isActive,
        this.isDeleted,
        this.departmentId,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate,
        this.otherName,
        this.openingBalance,
        this.note,
        this.customerTitleId,
        this.idNo,
        this.unrealizedChequeTotal,
        this.returnedChequeTotal,
        this.telephoneNo2,
        this.vatRegNo,
        this.companyRegNo,
        this.eoid,
        this.fid,
        this.entity,
        this.typeOfBusiness,
        this.subs,
        this.restricted,
        this.customerTypeId,
        this.customerType,
    });

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        isAddNew: json["isAddNew"],
        customerId: json["CustomerID"],
        customerNo: json["CustomerNo"],
        customerName: json["CustomerName"],
        addressLine1: json["AddressLine1"],
        addressLine2: json["AddressLine2"],
        addressLine3: json["AddressLine3"],
        city: json["City"],
        cityId: json["CityID"],
        customerArea: json["CustomerArea"],
        customerAreaId: json["CustomerAreaID"],
        email: json["Email"],
        telephoneNo: json["TelephoneNo"],
        mobileNo: json["MobileNo"],
        creditLimit: json["CreditLimit"],
        currentBalance: json["CurrentBalance"],
        creditDays: json["CreditDays"],
        isActive: json["IsActive"],
        isDeleted: json["IsDeleted"],
        departmentId: json["DepartmentID"],
        createdBy: json["CreatedBy"],
        createdDate: json["CreatedDate"],
        updatedBy: json["UpdatedBy"],
        updatedDate: json["UpdatedDate"],
        otherName: json["OtherName"],
        openingBalance: json["OpeningBalance"],
        note: json["Note"],
        customerTitleId: json["CustomerTitleID"],
        idNo: json["IDNo"],
        unrealizedChequeTotal: json["UnrealizedChequeTotal"],
        returnedChequeTotal: json["ReturnedChequeTotal"],
        telephoneNo2: json["TelephoneNo2"],
        vatRegNo: json["VATRegNo"],
        companyRegNo: json["CompanyRegNo"],
        eoid: json["EOID"],
        fid: json["FID"],
        entity: json["Entity"],
        typeOfBusiness: json["TypeOfBusiness"],
        subs: json["Subs"],
        restricted: json["Restricted"],
        customerTypeId: json["CustomerTypeID"],
        customerType: json["CustomerType"],
    );

    Map<String, dynamic> toJson() => {
        "isAddNew": isAddNew,
        "CustomerID": customerId,
        "CustomerNo": customerNo,
        "CustomerName": customerName,
        "AddressLine1": addressLine1,
        "AddressLine2": addressLine2,
        "AddressLine3": addressLine3,
        "City": city,
        "CityID": cityId,
        "CustomerArea": customerArea,
        "CustomerAreaID": customerAreaId,
        "Email": email,
        "TelephoneNo": telephoneNo,
        "MobileNo": mobileNo,
        "CreditLimit": creditLimit,
        "CurrentBalance": currentBalance,
        "CreditDays": creditDays,
        "IsActive": isActive,
        "IsDeleted": isDeleted,
        "DepartmentID": departmentId,
        "CreatedBy": createdBy,
        "CreatedDate": createdDate,
        "UpdatedBy": updatedBy,
        "UpdatedDate": updatedDate,
        "OtherName": otherName,
        "OpeningBalance": openingBalance,
        "Note": note,
        "CustomerTitleID": customerTitleId,
        "IDNo": idNo,
        "UnrealizedChequeTotal": unrealizedChequeTotal,
        "ReturnedChequeTotal": returnedChequeTotal,
        "TelephoneNo2": telephoneNo2,
        "VATRegNo": vatRegNo,
        "CompanyRegNo": companyRegNo,
        "EOID": eoid,
        "FID": fid,
        "Entity": entity,
        "TypeOfBusiness": typeOfBusiness,
        "Subs": subs,
        "Restricted": restricted,
        "CustomerTypeID": customerTypeId,
        "CustomerType": customerType,
    };
}

class SalesRep {
    bool? isAddNew;
    int? salesRepId;
    dynamic salesRepNo;
    dynamic salesRepTitleId;
    dynamic salesRepName;
    dynamic otherName;
    dynamic addressLine1;
    dynamic addressLine2;
    dynamic addressLine3;
    dynamic idNo;
    dynamic telephoneNo;
    dynamic mobileNo;
    dynamic email;
    dynamic note;
    bool? isActive;
    bool? isDeleted;
    dynamic createdBy;
    dynamic createdDate;
    dynamic updatedBy;
    dynamic updatedDate;

    SalesRep({
        this.isAddNew,
        this.salesRepId,
        this.salesRepNo,
        this.salesRepTitleId,
        this.salesRepName,
        this.otherName,
        this.addressLine1,
        this.addressLine2,
        this.addressLine3,
        this.idNo,
        this.telephoneNo,
        this.mobileNo,
        this.email,
        this.note,
        this.isActive,
        this.isDeleted,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate,
    });

    factory SalesRep.fromJson(Map<String, dynamic> json) => SalesRep(
        isAddNew: json["isAddNew"],
        salesRepId: json["SalesRepID"],
        salesRepNo: json["SalesRepNo"],
        salesRepTitleId: json["SalesRepTitleID"],
        salesRepName: json["SalesRepName"],
        otherName: json["OtherName"],
        addressLine1: json["AddressLine1"],
        addressLine2: json["AddressLine2"],
        addressLine3: json["AddressLine3"],
        idNo: json["IDNo"],
        telephoneNo: json["TelephoneNo"],
        mobileNo: json["MobileNo"],
        email: json["Email"],
        note: json["Note"],
        isActive: json["IsActive"],
        isDeleted: json["IsDeleted"],
        createdBy: json["CreatedBy"],
        createdDate: json["CreatedDate"],
        updatedBy: json["UpdatedBy"],
        updatedDate: json["UpdatedDate"],
    );

    Map<String, dynamic> toJson() => {
        "isAddNew": isAddNew,
        "SalesRepID": salesRepId,
        "SalesRepNo": salesRepNo,
        "SalesRepTitleID": salesRepTitleId,
        "SalesRepName": salesRepName,
        "OtherName": otherName,
        "AddressLine1": addressLine1,
        "AddressLine2": addressLine2,
        "AddressLine3": addressLine3,
        "IDNo": idNo,
        "TelephoneNo": telephoneNo,
        "MobileNo": mobileNo,
        "Email": email,
        "Note": note,
        "IsActive": isActive,
        "IsDeleted": isDeleted,
        "CreatedBy": createdBy,
        "CreatedDate": createdDate,
        "UpdatedBy": updatedBy,
        "UpdatedDate": updatedDate,
    };
}
