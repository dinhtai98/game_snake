import 'package:flutter/material.dart';
import 'package:snake/core/screens/home_screen.dart';
import 'package:snake/core/screens/splash.dart';

class MyRouter {
  static const String splash = '/splash';
  static const String home = '/home';

  static PageRouteBuilder _buildRouteNavigationWithoutEffect(
      RouteSettings settings, Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => widget,
      transitionDuration: Duration.zero,
      settings: settings,
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildRouteNavigationWithoutEffect(
          settings,
          SplashScreen(),
        );
      case home:
        return _buildRouteNavigationWithoutEffect(
          settings,
          HomeScreens(),
        );
      default:
        return _buildRouteNavigationWithoutEffect(
          settings,
          Scaffold(
            body: Center(
              child: Text('No route found: ${settings.name}.'),
            ),
          ),
        );
    }
  }

  static void onRouteChanged(String screenName) {}
}
