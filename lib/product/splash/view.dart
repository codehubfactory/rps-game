import 'package:flutter/material.dart';
import '../../core/base/modules/navigation/navigation_service.dart';
import '../../core/base/state.dart';
import '../../core/base/view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends BaseState<SplashView> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) => NavigationService.instance.navigateToPage(path: NavigationPaths.home));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      scaffoldBackgroundColor: colors.lightBlue,
      body: const Center(
        child: Icon(
          Icons.star,
          size: 65,
          color: Colors.amber, //TODO will change the icon
        ),
      ),
    );
  }
}
