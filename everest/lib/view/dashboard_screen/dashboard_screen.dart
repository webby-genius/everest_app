import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:everest/view/checkout_screen/check_out_screen.dart';
import 'package:everest/view/dashboard_screen/dashboard_provider.dart';
import 'package:everest/view/home_screen/home_provider.dart';
import 'package:everest/view/home_screen/home_screen.dart';
import 'package:everest/view/my_account/my_account_screen.dart';
import 'package:everest/view/pending_order/pending_order_screen.dart';
import 'package:everest/widgets/common_toast.dart';
import 'package:everest/widgets/logout_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> with WidgetsBindingObserver {
  // AdvancedDrawerController advancedDrawerController = AdvancedDrawerController();
  // int currentIndex = 0;
  late HomeScreen homeScreen;
  late DateTime backbuttonpressedTime;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<DashBoardProvider>(context, listen: false);
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // provider.currentIndex = 0;
    });
    homeScreen = HomeScreen(advancedDrawerController: provider.advancedDrawerController);
    debugPrint("12321231231231231🥶🥶🥶🥶🥶🥶🥶🥶");
  }

  @override
  void dispose() {
    // final provider = Provider.of<DashBoardProvider>(context, listen: false);
    debugPrint("<----------- DISPOSE 🥶🥶🥶🥶🥶🥶🥶🥶 DISPOSE -----------> ");
    WidgetsBinding.instance.removeObserver(this);
    // Provider.of<DashBoardProvider>(context, listen: false).advancedDrawerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressExit,
      child: Consumer(builder: (context, DashBoardProvider dashProvider, _) {
        return AdvancedDrawer(
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
          controller: dashProvider.advancedDrawerController,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: true,
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
                            const SizedBox(height: 40),
                            Divider(),
                            ListTile(
                              dense: true,
                              onTap: () => dashProvider.setScreen(0),
                              title: Text(
                                'Home Screen',
                                style: size18(fw: FW.medium, fontColor: ColorUtils.blackColor),
                              ),
                            ),
                            Divider(),
                            ListTile(
                              dense: true,
                              onTap: () => dashProvider.setScreen(1),
                              title: Text(
                                'My Account',
                                style: size18(fw: FW.medium, fontColor: ColorUtils.blackColor),
                              ),
                            ),
                            Divider(),
                            ListTile(
                              dense: true,
                              onTap: () {
                                setState(() {
                                  isMenuCheckOutScreen = true;
                                });
                                dashProvider.setScreen(2);
                              },
                              title: Text('View Basket', style: size18(fw: FW.medium, fontColor: ColorUtils.blackColor)),
                            ),
                            Divider(),
                            ListTile(
                              dense: true,
                              onTap: () {
                                setState(() {
                                  isPendingScreenTap = true;
                                });
                                dashProvider.setScreen(3);
                              },
                              title: Text('Pending Order', style: size18(fw: FW.medium, fontColor: ColorUtils.blackColor)),
                            ),
                            Divider(),
                            ListTile(
                              dense: true,
                              onTap: () {
                                dashProvider.advancedDrawerController.hideDrawer();
                                LogOutAlert.show(context);
                              },
                              leading: const Icon(Icons.logout_outlined, color: ColorUtils.blackColor, size: 22),
                              title: Text('Logout', style: size18(fw: FW.medium, fontColor: ColorUtils.blackColor)),
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          child: Consumer2(
            builder: (context, HomeProvider provider, DashBoardProvider dashBoardProvider, _) {
              return Scaffold(
                backgroundColor: Colors.white,
                // appBar: dashBoardProvider.currentIndex == 0 ? AppBar() : null,
                body: IndexedStack(
                  index: dashProvider.currentIndex,
                  children: [
                    KeepAliveWrapper(child: homeScreen),
                    MyAccountScreen(advancedDrawerController: dashProvider.advancedDrawerController),
                    OrderSummaryScreen(
                      isDrawerScreen: true,
                      advancedDrawerController: dashProvider.advancedDrawerController,
                      basket: provider.basket,
                      // isDrawerScreen: true,
                      // orderItems: provider.basket.entries.map((entry) {
                      //   return OrderItemModel(
                      //     productName: entry.key.itemName ?? '',
                      //     quantity: entry.value,
                      //     price: entry.key.salePrice.toString(),
                      //     itemId: entry.key.itemId ?? 0,
                      //   );
                      // }).toList(),
                    ),
                    PandingOrderScreen(advancedDrawerController: dashProvider.advancedDrawerController),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }

  // void setScreen(int index) {
  //   setState(() {
  //     currentIndex = index;
  //   });
  //   advancedDrawerController.hideDrawer();
  // }

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

class KeepAliveWrapper extends StatefulWidget {
  final Widget child;

  const KeepAliveWrapper({Key? key, required this.child}) : super(key: key);

  @override
  _KeepAliveWrapperState createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
