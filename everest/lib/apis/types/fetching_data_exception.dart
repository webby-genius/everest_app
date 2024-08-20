

import 'package:flutter/material.dart';

/// Class to handle Exceptions Based on Fetchind Data.
class FetchingDataException implements Exception {
  /// Constructor of FetchinfData Exceptions.
  FetchingDataException();
  final String _title = '''Fetching Data!''';
  final String _message = '''Fetching Data!''';

  /// getter of message.
  String getMessage() => _message;

  /// show snackbar.
  void showToast(BuildContext context) {
   
  }
}
