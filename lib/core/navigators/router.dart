import 'package:afroreads/core/navigators/route_name.dart';
import 'package:afroreads/features/onboarding/pages/onboarding_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute (RouteSettings settings){
  switch (settings.name) {
    case RouteName.onboardingScreen:
    return _getPageRoute(
        routeName: settings.name,
        viewToShow: const OnboardingScreen(),
      );
    default:
     return MaterialPageRoute<void>(
        builder: (_) => Scaffold(
          body: Center(
            child: Text(
              'No route defined for ${settings.name}',
            ),
          ),
        ),
      ); 
  }
}

PageRoute _getPageRoute({String? routeName, Widget? viewToShow}) {
  return MaterialPageRoute<void>(
    settings: RouteSettings(
      name: routeName,
    ),
    builder: (_) => viewToShow!,
  );
}
