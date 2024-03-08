import 'package:flutter/material.dart';

abstract class BaseNavigationService {
  Future navigateToPage({required String path, Object? arguments});
  Future<void> navigatePop<T extends Object?>({T res});
}

class NavigationService implements BaseNavigationService {
  static NavigationService? _instance;
  static NavigationService get instance {
    _instance ??= NavigationService._init();
    return _instance!;
  }

  NavigationService._init();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Future navigateToPage({required String path, Object? arguments}) async {
    return await navigatorKey.currentState!.pushNamed(path, arguments: arguments);
  }

  @override
  Future<void> navigatePop<T extends Object?>({T? res}) async {
    return navigatorKey.currentState!.pop<T>(res);
  }
}

class NavigationPaths {
  static const String home = '/home';
  static const String splash = '/splash';
  static const String win = '/win';
  static const String lose = '/lose';
  static const String scores = '/scores';
  static const String game = '/game';
}
