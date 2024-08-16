import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:everest/view/forget_password_screen/forget_pwd_provider.dart';
import 'package:everest/view/forget_password_screen/set_password_screen.dart';
import 'package:everest/widgets/button/center_text_button_widget.dart';
import 'package:everest/widgets/custom_images/asset_utils.dart';
import 'package:everest/widgets/custom_safearea.dart';
import 'package:everest/widgets/custom_textfield/textfield_widget.dart';
import 'package:everest/widgets/validations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPwdScreen extends StatefulWidget {
  const ForgetPwdScreen({super.key});

  @override
  State<ForgetPwdScreen> createState() => _ForgetPwdScreenState();
}

class _ForgetPwdScreenState extends State<ForgetPwdScreen> with Validators {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ForgetPwdProvider>(context, listen: false);
    provider.forgetEmailController.clear();
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
              "Forgot Password",
              style: size20(fw: FW.bold),
            ),
            centerTitle: true,
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
                      const SizedBox(height: 10),
                      Center(
                          child: assetPngUtils(assetImage: "assets/image/everest_wholesale logo.png", height: 200, width: 200)),
                      TextFieldWidget(
                        controller: provider.forgetEmailController,
                        hintText: "ID/Email",
                        lable: "Email address",
                        validator: validateEmailForm,
                      ),
                      const SizedBox(height: 40),
                      CenterTextButtonWidget(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SetPasswordScreen(),
                                ));
                            debugPrint("SUCCESS");
                          }
                          FocusScope.of(context).unfocus();
                        },
                        child: Text(
                          "Next",
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
