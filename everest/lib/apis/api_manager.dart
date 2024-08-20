// ignore_for_file: constant_identifier_names
import 'dart:convert';
import 'package:everest/apis/api.dart';
import 'package:everest/apis/exception/no_internet_exception.dart';
import 'package:everest/apis/types/api_exception.dart';
import 'package:everest/apis/types/authorization_exception.dart';
import 'package:everest/apis/types/general_api_exception.dart';
import 'package:everest/apis/types/page_not_found_exception.dart';
import 'package:everest/apis/types/server_exception.dart';
import 'package:everest/widgets/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

/// enum of apiTypes available to use.
enum APIMethodType { POST, GET, PUT }

enum APIBodyType { FORM_DATA, RAW, X_WWW_FORM_URL_ENCODED }

enum APIResponseStatus {
  SUCCESS,
  BAD_REQUEST,
  AUTHORIZATION,
  TIMEOUT,
  PAGE_NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  NO_INTERNET,
  UNKNOWN
}

/// Base Class of the application to handle all APIS.
class APIManager {
  /// base function of APIs.
  static Future<APIResponse> callAPI({
    BuildContext? context,
    required String url,
    required APIMethodType type,
    APIBodyType? apiBodyType,
    Map<String, dynamic>? body,
    Map<String, String>? header,
  }) async {
    List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();

    // debugPrint("🚀🚀🚀INTERNET-CONNECTIVITY $connectivityResult");

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet)) {
      try {
        debugPrint("🚀🚀🚀API-URL $url");
        if (body != null && body.isNotEmpty) {
          debugPrint("🚀🚀🚀API-BODY $body");
        }

        http.Response apiResponse;
        // String apiBody = jsonEncode(body);
        dynamic apiBody = body;

        /// integrity is the secret key for the application api calls.
        /// this is the very important and required for all the apis.
        Map<String, String> appHeader = {
          // "Content-Type": "application/x-www-form-urlencoded",
          // "Accept": "application/json",
          // "cache-control": "no-cache",
        };

        /// token has same importance as secret key.
        /// we can get token after login and registration apis.
        /// and all other apis except login and registration will require the
        /// token also with the secret key.

        String token = SharedPrefs.prefs.getString(SharedPrefs.userToken) ?? '';
        // StorageUtils.readStringValue(key: StorageKeyUtils.userToken) ?? '';
        if (token.isNotEmpty) {
          token = token.replaceAll('"', '');
          debugPrint("🫣🫣🫣🫣🫣 -->>>> $token");
          appHeader.addAll(
            {
              "Authorization": "Bearer $token",
            },
          );
        }
        //  "Authorization": "Bearer $token",
        /// if there are any other header for different kind of apis then attach
        /// dynamically passed parameters.
        if (header != null) {
          appHeader.addAll(header);
        }

        /// [POST CALL]
        if (type == APIMethodType.POST) {
          Object? bodyToSend;
          if (apiBodyType != null && apiBodyType == APIBodyType.RAW) {
            appHeader.addAll({'Content-type': 'application/json'});
            bodyToSend = jsonEncode(apiBody);
          } else {
            bodyToSend = apiBody;
          }

          /// call the api with the specified url using post method.
          apiResponse = await http
              .post(
            Uri.parse(url),
            body: bodyToSend,
            headers: appHeader,
          )
              .timeout(const Duration(seconds: 10), onTimeout: () {
            Map<String, dynamic> body = {"status": 0, "statuscode": 408, "msg": "timeout"};
            return http.Response(jsonEncode(body), 408);
          });
        }

        /// [GET CALL]
        else if (type == APIMethodType.GET) {
          /// call the api with the specified url using get method.
          apiResponse = await http
              .get(
            Uri.parse(url).replace(queryParameters: body ?? {}),
            headers: appHeader,
          )
              .timeout(const Duration(seconds: 10), onTimeout: () {
            Map<String, dynamic> body = {"status": 0, "statuscode": 408, "msg": "timeout"};
            return http.Response(jsonEncode(body), 408);
          });
        } else {
          /// call the api with hte specified url using put method.
          apiResponse = await http
              .put(
            Uri.parse(url),
            body: apiBody,
            headers: appHeader,
          )
              .timeout(const Duration(seconds: 10), onTimeout: () {
            Map<String, dynamic> body = {"status": 0, "statuscode": 408, "msg": "timeout"};
            return http.Response(jsonEncode(body), 408);
          });
        }

        dynamic response;
        if (apiResponse.headers['content-type'] == 'application/pdf') {
          response = {
            'status': 200,
          };
        } else {
          response = jsonDecode(apiResponse.body);
        }
        debugPrint("🚀🚀🚀API-HEADERS $appHeader");
        debugPrint("🚀🚀🚀API-STATUS-CODE ${apiResponse.statusCode} :: $url");
        debugPrint("🚀🚀🚀API-STATUS-RESPONSE ${apiResponse.body}");
        APIResponseStatus apiResponseStatus;
        if (apiResponse.statusCode >= 200 && apiResponse.statusCode <= 299) {
          apiResponseStatus = APIResponseStatus.SUCCESS;
        } else if (apiResponse.statusCode == 400) {
          apiResponseStatus = APIResponseStatus.BAD_REQUEST;
        } else if (apiResponse.statusCode == 401) {
          apiResponseStatus = APIResponseStatus.AUTHORIZATION;
        } else if (apiResponse.statusCode == 404) {
          apiResponseStatus = APIResponseStatus.PAGE_NOT_FOUND;
        } else if (apiResponse.statusCode == 408) {
          apiResponseStatus = APIResponseStatus.TIMEOUT;
          showDialog(
            context: context!,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                title: Text("TIME OUT"),
                content: Text("Please try again", style: TextStyle(fontSize: 14, color: Colors.black)),
                actions: [
                  MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel")),
                  MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                        callAPI(
                          context: context,
                          url: url,
                          type: type,
                          apiBodyType: apiBodyType,
                          body: body,
                          header: header,
                        );
                      },
                      child: const Text("Retry")),
                ],
              );
            },
          );
        } else if (apiResponse.statusCode >= 500) {
          apiResponseStatus = APIResponseStatus.INTERNAL_SERVER_ERROR;
        } else {
          apiResponseStatus = APIResponseStatus.UNKNOWN;
        }

        switch (apiResponseStatus) {
          case APIResponseStatus.SUCCESS:
            //  log("🚀🚀🚀API-RESPONSE ✅ ✅ ✅ ${json.decode(json.encode(response.toString()))}");
            debugPrint("🚀🚀🚀API-RESPONSE ✅ ✅ ✅ ${response.toString()}");
            // List<String> list =
            //     Utils.splitStringByLength(response.toString(), 960);
            // for (int i = 0; i < list.length; i++) {
            //   log("🚀🚀🚀API-RESPONSE ✅ ✅ ✅ ${list[i]}");
            // }

            return APIResponse(success: true, statuscode: apiResponseStatus, response: response);

          case APIResponseStatus.INTERNAL_SERVER_ERROR: // server error !
            /// when the error is from server side then it manage the response
            /// and show the snack accordingly.
            ServerException().showToast();
            return APIResponse(success: false, statuscode: apiResponseStatus, response: null);
          case APIResponseStatus.PAGE_NOT_FOUND: // page not found !

            /// when the page called from the application is not found
            /// then it show the message.
            PageNotFoundException().showToast();
            return APIResponse(success: false, statuscode: apiResponseStatus, response: null);

          case APIResponseStatus.BAD_REQUEST: // bad request !

            /// when the request is made with some mistakes or bad or
            /// improper parameters this part will execute.
            // Fluttertoast.showToast(msg: response['msg']);
            // motionToastWidget(context: context,motionType: MotionToastType.error,toastMsg: response['msg']);
            // BadRequestException().showToast();
            return APIResponse(success: false, statuscode: apiResponseStatus, response: null);

          case APIResponseStatus.AUTHORIZATION:
            AuthorizationException().showToast();
            debugPrint("🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶🥶");
            return APIResponse(success: false, statuscode: apiResponseStatus, response: null);
          default:

            /// when there is some other errors like server, page-not-found,
            /// bad connection then it will return null.
            GeneralAPIException().showToast();
            return APIResponse(success: false, statuscode: apiResponseStatus, response: null);
        }
      } catch (e) {
        debugPrint("API-RESPONSE-ERROR ${e.toString()}");
        APIException(message: e.toString()).showToast();
        return APIResponse(success: false, statuscode: APIResponseStatus.UNKNOWN, response: null);
      }
    } else {
      debugPrint('No Internet!');
      NoInternetExceptions().showNoNetworkWidget(
          context: context!,
          onCancelTap: () {
            Navigator.pop(context);
          },
          onRetryTap: () {
            Navigator.pop(context);
            callAPI(
              context: context,
              url: url,
              type: type,
              apiBodyType: apiBodyType,
              body: body,
              header: header,
            );
          });
      return APIResponse(
        success: false,
        statuscode: APIResponseStatus.NO_INTERNET,
        response: null,
      );
    }
  }
}
