import 'package:flutter/material.dart';

import 'alert_message.dart';

class NoInternetExceptions implements Exception {
  showNoNetworkWidget({
    required BuildContext context,
    required VoidCallback onCancelTap,
    required VoidCallback onRetryTap,
  }) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(AlertMessage.noInternet!),
          content: Text("Internet Not Available", style: TextStyle(color: Colors.black, fontSize: 14)),
          actions: [
            MaterialButton(onPressed: onCancelTap, child: const Text("Cancel")),
            MaterialButton(onPressed: onRetryTap, child: const Text("Retry")),
          ],
        );
      },
    );
  }
}
