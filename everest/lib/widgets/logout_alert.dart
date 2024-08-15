import 'package:everest/utils/colors.dart';
import 'package:everest/view/dashboard_screen/dashboard_screen.dart';
import 'package:everest/view/login_screen/login_screen.dart';
import 'package:everest/widgets/shared_prefs.dart';
import 'package:flutter/material.dart';

class LogOutAlert extends StatelessWidget {
  static show(context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              "Logout",
            ),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Are you sure you want to Logout?"),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "No",
                  style: TextStyle(
                    color: ColorUtils.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  "Yes",
                  style: TextStyle(
                    color: ColorUtils.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () async {
                  _logOutAPI(context: context);
                  // logoutDialogue();
                },
              ),
            ],
          );
        });
  }

  static _logOutAPI({
    required BuildContext context,
  }) async {
    SharedPrefs.prefs.clear();
    SharedPrefs.prefs.setBool(SharedPrefs.isLoginKey, false);

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
