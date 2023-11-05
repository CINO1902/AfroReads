import 'package:afroreads/core/navigators/route_name.dart';
import 'package:afroreads/core/navigators/router.dart';
import 'package:afroreads/core/service/locator.dart';
import 'package:afroreads/features/auth/presentation/provider/authPro.dart';
import 'package:afroreads/features/getbooks/presentation/provider/GetbooksPro.dart';
import 'package:afroreads/features/search/presentation/Provider/SearchPro.dart';
import 'package:afroreads/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  final value = pref.getString('tokenlogforparent');
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MyApp(
    value: value,
  ));
  setup();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.value});

  final String? value;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => initialization());
  }

  void initialization() async {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthPro(locator())),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => GetbookPro(locator())),
        ChangeNotifierProvider(create: (context) => Searchpro(locator())),
      ],
      child: Builder(builder: (BuildContext context) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          theme: themeProvider.themeData,
          navigatorObservers: [FlutterSmartDialog.observer],
          builder: FlutterSmartDialog.init(),
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          initialRoute: widget.value == null
              ? RouteName.onboardingScreen
              : RouteName.indexPage,
          onGenerateRoute: generateRoute,
          // home: const OnboardingScreen(),
        );
      }),
    );
  }
}
