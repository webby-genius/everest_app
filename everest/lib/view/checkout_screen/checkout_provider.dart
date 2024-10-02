import 'dart:convert';
import 'package:everest/apis/api.dart';
import 'package:everest/apis/api_manager.dart';
import 'package:everest/apis/api_urls.dart';
import 'package:everest/apis/models/checkout_save_model.dart';
import 'package:everest/view/checkout_screen/check_out_screen.dart';
import 'package:everest/widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// class SaveOrderItem {
//   int ItemID;
//   int Quantity;
//   SaveOrderItem({required this.ItemID, required this.Quantity});
// }

class SaveOrderItem {
  final int itemId;
  final int quantity;

  SaveOrderItem({
    required this.itemId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'ItemID': itemId,
      'Quantity': quantity,
    };
  }
}

class CheckOutProvider extends ChangeNotifier {
  String selectedOption = '1';

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String formatCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(now);
  }

  CheckOutSaveResponse checkOutSaveResponse = CheckOutSaveResponse();
  List<SaveOrderItem> saveOrderItems = [];
  Future checkOutSaveApiResponse({
    required BuildContext context,
    required List<OrderItemModel> orderItems,
  }) async {
    saveOrderItems.clear();
    List<SaveOrderItem> convertOrderItemsToSaveOrderItems(List<OrderItemModel> orderItems) {
      return orderItems
          .map((item) => SaveOrderItem(
                itemId: item.itemId,
                quantity: item.quantity,
              ))
          .toList();
    }

    saveOrderItems = convertOrderItemsToSaveOrderItems(orderItems);
    debugPrint("saveOrderItems ${saveOrderItems.length}---->>>>> ${saveOrderItems.first.itemId}");

    isLoading = true;
    notifyListeners();
    Map<String, dynamic> bodyData = {
      "OrderDateTime": formatCurrentDate(), //"03 September 2024",
      "OrderTypeID": selectedOption,
      "Items": saveOrderItems,
    };
    debugPrint("bodyData --->>> $bodyData");
    try {
      APIResponse response = await APIManager.callAPI(
        context: context,
        url: ApiUrlPage.saveOrderCartUrl,
        type: APIMethodType.POST,
        apiBodyType: APIBodyType.RAW,
        body: bodyData,
      );
      if (response.success) {
        checkOutSaveResponse = CheckOutSaveResponse.fromJson(response.response);
        if (checkOutSaveResponse != null) {
          debugPrint("!!!!!!!!!!!---------- SUCESS! ----------!!!!!!!!!!");
          FlutterToastWidget.show("Order save successfully!", "success");
          notifyListeners();
        } else {
          FlutterToastWidget.show("Somthing went wrong!", "error");
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
}
