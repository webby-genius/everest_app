import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:everest/view/forget_password_screen/forget_pwd_screen.dart';
import 'package:everest/view/login_screen/login_provider.dart';
import 'package:everest/widgets/LoadingWidget.dart';
import 'package:everest/widgets/button/center_text_button_widget.dart';
import 'package:everest/widgets/custom_images/asset_utils.dart';
import 'package:everest/widgets/custom_safearea.dart';
import 'package:everest/widgets/custom_textfield/textfield_widget.dart';
import 'package:everest/widgets/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Validators {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      child: Consumer(builder: (context, LoginProvider provider, _) {
        return CircularProgressIndicatorWidget(
          visible: provider.isLoading,
          child: Scaffold(
            backgroundColor: ColorUtils.whiteColor,
            // resizeToAvoidBottomInset: false,
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
                        const SizedBox(height: 20),
                        Center(
                            child: assetPngUtils(
                          assetImage: "assets/image/everest_wholesale logo.png",
                          height: 200,
                          width: 200,
                        )),
                        TextFieldWidget(
                          controller: provider.emailController,
                          hintText: "Username",
                          lable: "Username",
                          validator: userName,
                        ),
                        const SizedBox(height: 15),
                        TextFieldWidget(
                          controller: provider.passwordController,
                          hintText: "********",
                          lable: "Password",
                          isObSecure: provider.obSecureData,
                          textInputAction: TextInputAction.done,
                          validator: validateIsStrongPassword,
                          suffixIcon: IconButton(
                            onPressed: () {
                              provider.obSecureData = !provider.obSecureData;
                            },
                            icon: provider.obSecureData ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Visibility(
                          visible: false,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ForgetPwdScreen(),
                                    ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "Forgot Password?",
                                  style: size15(fontColor: ColorUtils.darkChatBubbleColor, fw: FW.medium),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        CenterTextButtonWidget(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              provider.loginApiResponse(context: context);
                              debugPrint("SUCCESS");
                            }
                            FocusScope.of(context).unfocus();
                          },
                          child: Text(
                            "Login",
                            style: size20(fontColor: ColorUtils.whiteColor, fw: FW.bold),
                          ),
                        ),
                      ],
                    ),
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
