import 'package:everest/apis/api.dart';
import 'package:everest/apis/api_manager.dart';
import 'package:everest/apis/api_urls.dart';
import 'package:everest/apis/models/my_account_model.dart';
import 'package:flutter/material.dart';

class MyAccountProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  UserInfoResponse userInfoResponse = UserInfoResponse();

  Future userInfoApiResponse({required BuildContext context}) async {
    isLoading = true;
    // debugPrint("bodyData -->> $bodyData");
    try {
      APIResponse response = await APIManager.callAPI(
        context: context,
        url: ApiUrlPage.userInfoUrl,
        type: APIMethodType.GET,
        // body: bodyData,
      );

      if (response.success) {
        userInfoResponse = UserInfoResponse.fromJson(response.response!);
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
