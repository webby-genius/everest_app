import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:everest/view/forget_password_screen/forget_pwd_provider.dart';
import 'package:everest/view/login_screen/login_screen.dart';
import 'package:everest/widgets/button/center_text_button_widget.dart';
import 'package:everest/widgets/common_toast.dart';
import 'package:everest/widgets/custom_images/asset_utils.dart';
import 'package:everest/widgets/custom_safearea.dart';
import 'package:everest/widgets/custom_textfield/textfield_widget.dart';
import 'package:everest/widgets/validations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> with Validators {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ForgetPwdProvider>(context, listen: false);
    provider.conformPasswordController.clear();
    provider.newPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      child: Consumer(builder: (context, ForgetPwdProvider provider, _) {
        return Scaffold(
          backgroundColor: ColorUtils.whiteColor,
          // resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              "Reset Password",
              style: size20(fw: FW.bold),
            ),
          ),
          body: GestureDetector(
            onTap: () {
              setState(() {
                FocusScope.of(context).unfocus();
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: assetPngUtils(
                        assetImage: "assets/image/everest_wholesale logo.png",
                        height: 200,
                        width: 200,
                      )),
                      // Text(
                      //   "Enter New Password",
                      //   style: size22(fw: FW.bold, fontColor: ColorUtils.darkChatBubbleColor),
                      // ),
                      // Text(
                      //   "Password must be 8-20 characters long",
                      //   style: size12(fontColor: ColorUtils.darkChatBubbleColor.withOpacity(0.5)),
                      // ),
                      const SizedBox(height: 10),
                      TextFieldWidget(
                        controller: provider.newPasswordController,
                        hintText: "********",
                        lable: "New Password",
                        isObSecure: provider.newObSecureData,
                        validator: validateIsStrongPassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            provider.newObSecureData = !provider.newObSecureData;
                          },
                          icon: provider.newObSecureData ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFieldWidget(
                        controller: provider.conformPasswordController,
                        hintText: "********",
                        lable: "Conform Password",
                        isObSecure: provider.obSecureData,
                        validator: validateIsStrongPassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            provider.obSecureData = !provider.obSecureData;
                          },
                          icon: provider.obSecureData ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                        ),
                      ),
                      const SizedBox(height: 40),
                      CenterTextButtonWidget(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            debugPrint("SUCCESS");
                            if (provider.conformPasswordController.text == provider.newPasswordController.text) {
                              Navigator.pushAndRemoveUntil(
                                  context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
                              provider.clearFields();
                            } else {
                              FlutterToastWidget.show("Passwords do not match. Please check and try again.", "error");
                            }
                          }
                          FocusScope.of(context).unfocus();
                        },
                        child: Text(
                          "Submit",
                          style: size20(fontColor: ColorUtils.whiteColor, fw: FW.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
