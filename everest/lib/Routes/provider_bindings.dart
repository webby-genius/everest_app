import 'package:everest/view/barcode_screen/barcode_provider.dart';
import 'package:everest/view/checkout_screen/checkout_provider.dart';
import 'package:everest/view/dashboard_screen/dashboard_provider.dart';
import 'package:everest/view/forget_password_screen/forget_pwd_provider.dart';
import 'package:everest/view/home_screen/home_provider.dart';
import 'package:everest/view/login_screen/login_provider.dart';
import 'package:everest/view/my_account/my_account_provider.dart';
import 'package:everest/view/pending_order/pending_order_provider.dart';
import 'package:everest/view/splash_screen/splash_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProviderBindings {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => DashBoardProvider()),
    ChangeNotifierProvider(create: (_) => SplashProvider()),
    ChangeNotifierProvider(create: (_) => LoginProvider()),
    ChangeNotifierProvider(create: (_) => ForgetPwdProvider()),
    ChangeNotifierProvider(create: (_) => HomeProvider()),
    ChangeNotifierProvider(create: (_) => BarcodeProvider()),
    ChangeNotifierProvider(create: (_) => MyAccountProvider()),
    ChangeNotifierProvider(create: (_) => CheckOutProvider()),
    ChangeNotifierProvider(create: (_) => PendingProvider()),
  ];
}
