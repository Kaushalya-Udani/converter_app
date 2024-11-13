import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../features/pages/home/home_page.dart';
import '../features/pages/splash_page/splash_page.dart';


class Routes {
  static const String rSplashView = "rSplashView";
  static const String rHomeView = "rHomeView";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.rSplashView:
        return PageTransition(
          child: const SplashScreen(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.rSplashView),
        );
      case Routes.rHomeView:
        return PageTransition(
          child: const HomePage(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.rHomeView),
        );
      default:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const Scaffold(
            body: Center(
              child: Text("Invalid Route"),
            ),
          ),
        );
    }
  }
}
