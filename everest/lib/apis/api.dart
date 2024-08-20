library provider_app_apis;

import 'api_manager.dart';

class APIResponse {
  bool success;
  APIResponseStatus statuscode;
  dynamic response;
  // Map<String, dynamic>? response;
  APIResponse({required this.success, required this.statuscode, this.response});
}
