import 'package:afroreads/core/navigators/route_name.dart';
import 'package:afroreads/features/auth/pages/final_sign_up_verification_page.dart';
import 'package:afroreads/features/auth/pages/parent_sign_up_page.dart';
import 'package:afroreads/features/auth/pages/sign_up_verification_page.dart';
import 'package:afroreads/features/onboarding/pages/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:afroreads/features/auth/pages/sign_up_page.dart';

Route<dynamic> generateRoute (RouteSettings settings){
  switch (settings.name) {
    case RouteName.onboardingScreen:
    return _getPageRoute(
        routeName: settings.name,
        viewToShow: const OnboardingScreen(),
      );
     case RouteName.signUpPage:
    return _getPageRoute(
        routeName: settings.name,
        viewToShow: const SignUpPage(),
      );
     case RouteName.signUpVerificationPage:
    return _getPageRoute(
        routeName: settings.name,
        viewToShow: const SignUpVerificationPage(),
      ); 
       case RouteName.finalSignUpVerificationPage:
    return _getPageRoute(
        routeName: settings.name,
        viewToShow: const FinalSignUpVerificationPage(),
      ); 
      case RouteName.parentSignUpPage:
    return _getPageRoute(
        routeName: settings.name,
        viewToShow: const ParentSignUpPage(),
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
