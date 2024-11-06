import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tots_test/features/auth/ui/login.dart';
import 'package:tots_test/features/error/error.dart';
import 'package:tots_test/features/home/ui/home.dart';
import 'package:tots_test/utils/logger.dart';

final customRouterProvider = Provider<CustomRouter>((ref) {
  return CustomRouter();
});

class CustomRouter {
  CustomRouter();

  bool _isAuthenticated = false;

  set isAuthenticated(bool value) {
    CustomLogger.log('Setting is authenticated: _isAuthenticated with $value');
    _isAuthenticated = value;
  }

  bool get isAuthenticated => _isAuthenticated;

  Route onGenerateRoute(RouteSettings settings) {
    CustomLogger.log('////////////////////////////////////////');
    CustomLogger.log('==== GO TO ====');
    CustomLogger.log('Go to route: ${settings.name}');
    CustomLogger.log('Arguments: ${settings.arguments}');
    CustomLogger.log('authenticated: $_isAuthenticated');
    CustomLogger.log('////////////////////////////////////////');
    return _isAuthenticated
        ? _authenticatedRoutes(settings)
        : _notAuthenticatedRoutes(settings);
  }

  Route _onErrorScreen(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const ErrorScreen(
        title: 'Sorry!!, Ha ocurrido un error',
      ),
    );
  }

  Route _authenticatedRoutes(RouteSettings settings) {
    switch (settings.name) {
      case LoginPage.route:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
          settings: settings,
        );
      case HomePage.route:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
          settings: settings,
        );
      default:
        return _onErrorScreen(settings);
    }
  }

  Route _notAuthenticatedRoutes(RouteSettings settings) {
    switch (settings.name) {
      case LoginPage.route:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
          settings: settings,
        );
      default:
        return _onErrorScreen(settings);
    }
  }
}
