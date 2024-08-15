import 'package:everest/utils/colors.dart';
import 'package:everest/view/splash_screen/splash_provider.dart';
import 'package:everest/widgets/custom_images/asset_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final provider = Provider.of<SplashProvider>(context, listen: false);
    provider.onReady(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.whiteColor,
      body: Center(
          child: assetPngUtils(
        assetImage: "assets/image/everest_wholesale logo.png",
        height: 200,
        width: 200,
      )),
    );
  }
}
