import 'package:everest/view/login_screen/login_provider.dart';
import 'package:everest/view/splash_screen/splash_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProviderBindings {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => SplashProvider()),
    ChangeNotifierProvider(create: (_) => LoginProvider()),
  ];
}
