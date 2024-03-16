import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'core/base/modules/alert/alert_manager.dart';
import 'core/base/modules/navigation/navigation_route.dart';
import 'core/base/modules/navigation/navigation_service.dart';
import 'product/splash/view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.instance.navigatorKey,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      scaffoldMessengerKey: AlertManager.instance.alertKey,
      title: 'Rock Paper Scissors',
      home: const SplashView(),
    );
  }
}
