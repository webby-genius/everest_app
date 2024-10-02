import 'package:everest/apis/api.dart';
import 'package:everest/apis/api_manager.dart';
import 'package:everest/apis/api_urls.dart';
import 'package:everest/apis/models/product_item_model.dart';
import 'package:everest/widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BarcodeProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  ProductItemResponse productItemResponse = ProductItemResponse();
  ProductItemResponse? scannedProduct;

  List<dynamic> productsToShow = [];

  Future getItemByBarcodeApiResponse({
    required BuildContext context,
    required String barcode,
  }) async {
    isLoading = true;
    notifyListeners();
    Map<String, String> parameter = {"Barcode": barcode};
    APIResponse response = await APIManager.callAPI(
      context: context,
      url: ApiUrlPage.getSingleItemByBarcodeUrl,
      type: APIMethodType.GET,
      body: parameter,
    );
    if (response.success) {
      isLoading = false;
      productItemResponse = ProductItemResponse.fromJson(response.response);
      scannedProduct = productItemResponse;
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();
      // FlutterToastWidget.show("Item not found", "error");
      productsToShow.clear();
      debugPrint("");
    }
    notifyListeners();
  }
}
