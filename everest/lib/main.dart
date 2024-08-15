import 'package:everest/Routes/app_route.dart';
import 'package:everest/Routes/provider_bindings.dart';
import 'package:everest/utils/colors.dart';
import 'package:everest/view/splash_screen/splash_screen.dart';
import 'package:everest/widgets/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: ProviderBindings.providers,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: ColorUtils.whiteColor,
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(background: ColorUtils.blackColor10),
          ),
          onGenerateRoute: RouteUtils.onGenerateRoute,
          home: SplashScreen(),
        ));
  }
}
