import 'package:afroreads/core/navigators/route_name.dart';
import 'package:afroreads/features/auth/presentation/pages/child_sign_in_page.dart';
import 'package:afroreads/features/auth/presentation/pages/final_sign_up_verification_page.dart';
import 'package:afroreads/features/auth/presentation/pages/parent_sign_in_page.dart';
import 'package:afroreads/features/auth/presentation/pages/sign_up_verification_page.dart';
import 'package:afroreads/features/getbooks/presentation/pages/bookdetails.dart';
import 'package:afroreads/features/getbooks/presentation/pages/home.dart';
import 'package:afroreads/features/getbooks/presentation/pages/index.dart';
import 'package:afroreads/features/getbooks/presentation/pages/pdfscreen.dart';
import 'package:afroreads/features/getuserdetails/presentation/pages/createkidprofile.dart';
import 'package:afroreads/features/getuserdetails/presentation/pages/kidprofilesetting.dart';
import 'package:afroreads/features/getuserdetails/presentation/pages/managekidprofile.dart';
import 'package:afroreads/features/onboarding/pages/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:afroreads/features/auth/presentation/pages/sign_up_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
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
    case RouteName.pdfpage:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const PdfScreen(),
      );
    case RouteName.parentSignUpPage:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const ParentSignUpPage(),
      );
    case RouteName.childSignUpPage:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const ChildSignUpPage(),
      );  
    case RouteName.homePage:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const Home(),
      );
    case RouteName.bookdetails:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const BookDetails(),
      );
    case RouteName.indexPage:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const Homelanding(),
      );
    case RouteName.kidprofilesetting:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const kidprogilesetting(),
      );
    case RouteName.createkidprofile:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const Createkidprofile(),
      );
    case RouteName.managekidprofile:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const managekidprofile(),
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
