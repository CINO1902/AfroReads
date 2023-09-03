import 'package:afroreads/core/navigators/route_name.dart';
import 'package:afroreads/core/navigators/router.dart';
import 'package:afroreads/core/service/locator.dart';
import 'package:afroreads/features/auth/presentation/provider/authPro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
  setup();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthPro(locator())),
      ],
      child: MaterialApp(
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: FlutterSmartDialog.init(),
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: RouteName.onboardingScreen,
        onGenerateRoute: generateRoute,
        // home: const OnboardingScreen(),
      ),
    );
  }
}
