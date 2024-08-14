import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:everest/view/home_screen/home_screen.dart';
import 'package:everest/view/my_account/my_account_screen.dart';
import 'package:everest/view/pending_order/pending_order_screen.dart';
import 'package:everest/view/view_basket/view-basket_screen.dart';
import 'package:everest/widgets/common_toast.dart';
import 'package:everest/widgets/logout_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> with WidgetsBindingObserver {
  AdvancedDrawerController advancedDrawerController = AdvancedDrawerController();
  bool isPaused = false;
  bool isMyAccountOpen = false;
  bool isTaxForms = false;
  bool isUsefulLink = false;
  String liveChateShow = '';
  late DateTime backbuttonpressedTime;
  @override
  void initState() {
    super.initState();
    // final provider = Provider.of<CreatePayStubProvider>(context, listen: false);
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("😡🥶😡🥶 <-----------------------------------> 😡🥶😡🥶");
    WidgetsBinding.instance.removeObserver(this);
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressExit,
      child: AdvancedDrawer(
        disabledGestures: true,
        backdrop: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [ColorUtils.whiteColor90, ColorUtils.whiteColor],
            ),
          ),
        ),
        controller: advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        // rtlOpening: true,

        childDecoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16))),
        drawer: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: ListTileTheme(
              textColor: Colors.white,
              iconColor: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          ListTile(
                            dense: true,
                            onTap: () {
                              setState(() {
                                Future.microtask(() {
                                  setScreen(0);
                                });
                              });
                            },
                            title: Text(
                              'Home Screen',
                              style: size16(fw: FW.medium, fontColor: ColorUtils.blackColor),
                            ),
                          ),
                          ListTile(
                            dense: true,
                            onTap: () {
                              setState(() {
                                Future.microtask(() {
                                  setScreen(1);
                                });
                              });
                            },
                            title: Text(
                              'My Account',
                              style: size16(fw: FW.medium, fontColor: ColorUtils.blackColor),
                            ),
                          ),
                          ListTile(
                            dense: true,
                            onTap: () {
                              setState(() {
                                Future.microtask(() {
                                  setScreen(2);
                                });
                              });
                            },
                            title: Text('View Basket', style: size16(fw: FW.medium, fontColor: ColorUtils.blackColor)),
                          ),
                          ListTile(
                            dense: true,
                            onTap: () {
                              setState(() {
                                Future.microtask(() {
                                  setScreen(3);
                                });
                              });
                            },
                            title: Text('Pending Order', style: size16(fw: FW.medium, fontColor: ColorUtils.blackColor)),
                          ),
                          ListTile(
                            dense: true,
                            onTap: () {
                              advancedDrawerController.hideDrawer();
                              LogOutAlert.show(context);
                              setState(() {});
                            },
                            leading: const Icon(Icons.logout_outlined, color: ColorUtils.blackColor, size: 22),
                            title: Text('Logout', style: size16(fw: FW.medium, fontColor: ColorUtils.blackColor)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: currentIndex == 0
              ? HomeScreen(advancedDrawerController: advancedDrawerController)
              : currentIndex == 1
                  ? MyAccountScreen(advancedDrawerController: advancedDrawerController)
                  : currentIndex == 2
                      ? ViewBasketScreen(advancedDrawerController: advancedDrawerController)
                      : PandingOrderScreen(advancedDrawerController: advancedDrawerController),
        ),
      ),
    );
  }

  void setScreen(int index) {
    setState(() {
      currentIndex = index;
    });
    debugPrint("currentIndex --->>> $currentIndex");
    advancedDrawerController.hideDrawer();
  }

  Future<bool> onBackPressExit() async {
    DateTime currentTime = DateTime.now();
    bool backButton = currentTime.difference(backbuttonpressedTime) > const Duration(seconds: 1);
    if (backButton) {
      backbuttonpressedTime = currentTime;
      FlutterToastWidget.show("Press again to exit app.", 'error');
      return false;
    } else {
      debugPrint("🥶🥶🥶🥶🥶🥶🥶🥶");
    }
    return true;
  }
}
