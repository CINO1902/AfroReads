import 'package:afroreads/core/navigators/route_name.dart';
import 'package:afroreads/core/navigators/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: RouteName.onboardingScreen,
      onGenerateRoute: generateRoute,
      // home: const OnboardingScreen(),
    );
  }
}
