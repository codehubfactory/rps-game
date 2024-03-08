import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r_p_s_game/core/bloc/block_manager.dart';
import 'package:r_p_s_game/product/game/view.dart';
import 'package:r_p_s_game/product/score/view.dart';
import 'package:r_p_s_game/product/splash/view.dart';
import '../../../../product/home/view.dart';
import 'navigation_service.dart';

class NavigationRoute {
  static NavigationRoute? _instance;
  static NavigationRoute get instance {
    _instance ??= NavigationRoute._init();
    return _instance!;
  }

  NavigationRoute._init();

  Route generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationPaths.home:
        return normalNavigate(const HomeView());
      case NavigationPaths.splash:
        return normalNavigate(const SplashView());
      case NavigationPaths.scores:
        return normalNavigate(const ScoreView());
      case NavigationPaths.game:
        return normalNavigate(
          BlocProvider<ScoreBloc>(
            create: (BuildContext context) => ScoreBloc(ScoreState.instance),
            child: const GameView(),
          ),
        );
      default:
        return normalNavigate(const SplashView());
    }
  }

  PageRoute normalNavigate(Widget widget) {
    return CupertinoPageRoute(builder: (context) => widget);
  }

  PageRoute normalNavigateToPop(Widget widget) {
    return CupertinoPageRoute(builder: (context) => widget, fullscreenDialog: true);
  }
}
