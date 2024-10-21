import 'dart:convert';

import 'package:everest/apis/api.dart';
import 'package:everest/apis/api_manager.dart';
import 'package:everest/apis/api_urls.dart';
import 'package:everest/apis/models/pending_order_model.dart';
import 'package:everest/widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PendingProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isShowNoData = false;

  List<PendingOrderResponse> pendingOrderList = [];

  PendingOrderResponse pendingOrderResponse = PendingOrderResponse();
  Future getCustomerOrdersApiResponse({required BuildContext context}) async {
    isLoading = true;
    // notifyListeners();

    DateTime currentDate = DateTime.now();
    DateTime oneYearAgo = currentDate.subtract(Duration(days: 365));

    String formattedStartDate =
        "${oneYearAgo.month.toString().padLeft(2, '0')}/${oneYearAgo.day.toString().padLeft(2, '0')}/${oneYearAgo.year}";
    String formattedEndDate =
        "${currentDate.month.toString().padLeft(2, '0')}/${currentDate.day.toString().padLeft(2, '0')}/${currentDate.year}";

    Map<String, dynamic> parameter = {
      "StartDate": formattedStartDate,
      "EndDate": formattedEndDate,
    };
    debugPrint("parameter --->>> $parameter");
    try {
      APIResponse response = await APIManager.callAPI(
        context: context,
        url: ApiUrlPage.getCustomerOrdersUrl,
        type: APIMethodType.GET,
        body: parameter,
      );

      if (response.success) {
        List<PendingOrderResponse> pendingOrderResponse = pendingOrderResponseFromJson(json.encode(response.response));
        if (pendingOrderResponse.isNotEmpty) {
          pendingOrderList.clear();
          pendingOrderList = pendingOrderResponse;
          if (pendingOrderList.isEmpty) {
            isShowNoData = true;
            // notifyListeners();
          }
          // notifyListeners();
        } else {
          FlutterToastWidget.show("No order found.", "error");
        }
      } else {
        // Handle error in response
        isLoading = false;
        // notifyListeners();
      }
    } catch (e) {
      debugPrint("ERROR ---------> ${e}");
    } finally {
      isLoading = false;
      // notifyListeners();
    }
  }

  // Future getCustomerOrdersApiResponse({required BuildContext context}) async {
  //   isLoading = true;
  //   Map<String, dynamic> perameter = {
  //     "StartDate":
  //     "EndDate":
  //   };
  //   try {
  //     APIResponse response = await APIManager.callAPI(
  //       context: context,
  //       url: ApiUrlPage.getCustomerOrdersUrl,
  //       type: APIMethodType.GET,
  //       body: perameter,
  //     );
  //     if (response.success) {
  //       isLoading = false;
  //     } else {
  //       isLoading = false;
  //     }
  //   } catch (e) {
  //     isLoading = false;
  //     debugPrint("ERROR ---------> ${e}");
  //   }
  //   notifyListeners();
  // }
}
