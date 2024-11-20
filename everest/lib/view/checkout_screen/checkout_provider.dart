import 'package:everest/apis/api.dart';
import 'package:everest/apis/api_manager.dart';
import 'package:everest/apis/api_urls.dart';
import 'package:everest/apis/models/cart_item_list_model.dart';
import 'package:everest/apis/models/checkout_save_model.dart';
import 'package:everest/apis/models/proceed_order_model.dart';
import 'package:everest/view/dashboard_screen/dashboard_provider.dart';
import 'package:everest/view/dashboard_screen/dashboard_screen.dart';
import 'package:everest/view/home_screen/home_provider.dart';
import 'package:everest/widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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

  CartItemsListResponse cartItemsListResponse = CartItemsListResponse();
  Future getShoppingCartItemListUrlResponse({required BuildContext context}) async {
    isLoading = true;
    try {
      APIResponse response = await APIManager.callAPI(
        context: context,
        url: ApiUrlPage.getShoppingCartItemListUrl,
        type: APIMethodType.GET,
      );
      if (response.success) {
        cartItemsListResponse = CartItemsListResponse.fromJson(response.response);
        if (cartItemsListResponse != null) {
          debugPrint("!!!!!!!!!!!---------- SUCESS! ----------!!!!!!!!!!");
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

  String formatCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(now);
  }

  CheckOutSaveResponse checkOutSaveResponse = CheckOutSaveResponse();
  // List<SaveOrderItem> saveOrderItems = [];
  Future checkOutSaveApiResponse({
    required BuildContext context,
    required List<Map<String, dynamic>> orderItems,
    bool isDrawerScreen = false,
  }) async {
    // saveOrderItems.clear();
    // List<SaveOrderItem> convertOrderItemsToSaveOrderItems(List<OrderItemModel> orderItems) {
    //   return orderItems
    //       .map((item) => SaveOrderItem(
    //             itemId: item.itemId,
    //             quantity: item.quantity,
    //           ))
    //       .toList();
    // }

    // saveOrderItems = convertOrderItemsToSaveOrderItems(orderItems);
    // debugPrint("saveOrderItems ${saveOrderItems.length}---->>>>> ${saveOrderItems.first.itemId}");

    isLoading = true;
    notifyListeners();
    Map<String, dynamic> bodyData = {
      "OrderDateTime": formatCurrentDate(), //"03 September 2024",
      "OrderTypeID": selectedOption,
      "Items": orderItems,
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
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => DashBoardScreen(),
          //     ),
          //     (route) => false);
          if (isDrawerScreen) {
            Provider.of<HomeProvider>(context, listen: false).clearBasket();
            Provider.of<DashBoardProvider>(context, listen: false).setScreen(0);
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashBoardScreen()),
            );
          }
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

  ProceedOrderResponse proceedOrderResponse = ProceedOrderResponse();

  Future proceedToOrderApiResponse({
    required BuildContext context,
    required List<Map<String, dynamic>> orderItems,
    bool isDrawerScreen = false,
  }) async {
    isLoading = true;
    notifyListeners();
    Map<String, dynamic> bodyData = {
      "OrderDateTime": formatCurrentDate(), //"03 September 2024",
      "Note": "Any note here",
      "OrderTypeID": selectedOption,
      "Items": orderItems,
    };
    debugPrint("bodyData --->>> $bodyData");
    try {
      APIResponse response = await APIManager.callAPI(
        context: context,
        url: ApiUrlPage.proceedToOrderUrl,
        type: APIMethodType.POST,
        apiBodyType: APIBodyType.RAW,
        body: bodyData,
      );
      if (response.success) {
        proceedOrderResponse = ProceedOrderResponse.fromJson(response.response);
        if (proceedOrderResponse != null) {
          debugPrint("!!!!!!!!!!!---------- SUCESS! ----------!!!!!!!!!!");
          FlutterToastWidget.show(proceedOrderResponse.message, "success");
          if (isDrawerScreen) {
            Provider.of<DashBoardProvider>(context, listen: false).setScreen(0);
          } else {
            Navigator.pop(context);
          }
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
