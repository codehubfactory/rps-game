import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:r_p_s_game/core/base/modules/alert/alert_manager.dart';
import 'package:r_p_s_game/core/base/state.dart';
import 'package:r_p_s_game/core/bloc/block_manager.dart';
import 'package:r_p_s_game/product/game/view.dart';
import '../../core/base/modules/extension/asset_extension.dart';
import '../../core/components/svg_widget.dart';

abstract class GameViewmodel extends BaseState<GameView> {
  Widget? selectedWidgetUser;
  Widget? selectedWidgetApp;
  bool youWin = false;
  bool youLose = false;
  int index = 0;
  int indexApp = 0;
  bool stoppedAnimation = false;
  bool stoppedAnimationApp = false;
  final Random random = Random();
  InterstitialAd? interstitialAd;
  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-9585663775364638/9935584164',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              // _moveToHome();
            },
          );
          setState(() {
            interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }

  @override
  void initState() {
    index = 0;
    indexApp = 0;
    _startAnimation();
    loadInterstitialAd();
    super.initState();
  }

  List<Widget> widgets = [svgWidget(GameAsset.rock, 200), iconWidget(Icons.menu_book, 200), iconWidget(Icons.cut, 200)];
  void _startAnimation() {
    Future.delayed(const Duration(microseconds: 1000000), () {
      setState(() {
        index = (index + 1) % widgets.length;
        _startAnimation();
      });
    });
  }

  void _startAnimationApp() {
    Future.delayed(const Duration(microseconds: 50000), () {
      setState(() {
        indexApp = random.nextInt(widgets.length);
        _startAnimationApp();
      });
    });
  }

  void stopAnimation() {
    selectedWidgetUser = widgets[index];
    stoppedAnimation = true;
    index = 0;
    _startAnimationApp();
    Future.delayed(const Duration(seconds: 5)).then((value) => stopAnimationApp());
  }

  void stopAnimationApp() {
    selectedWidgetApp = widgets[indexApp];
    stoppedAnimationApp = true;
    chooseWinner();
  }

  void chooseWinner() {
    if (selectedWidgetApp == selectedWidgetUser) {
      AlertManager.instance.showSnack(SnackType.warning, message: "NO WINNER!");
      Future.delayed(const Duration(seconds: 3)).then((value) {
        stoppedAnimation = false;
        stoppedAnimationApp = false;
        index = 0;
        youWin = false;
        youLose = false;
      });
    } else if (selectedWidgetUser == widgets[0] && selectedWidgetApp == widgets[1] ||
        selectedWidgetUser == widgets[1] && selectedWidgetApp == widgets[2] ||
        selectedWidgetUser == widgets[2] && selectedWidgetApp == widgets[0]) {
      youLose = true;
      BlocProvider.of<ScoreBloc>(context).decrement();
      AlertManager.instance.showSnack(SnackType.error, message: "YOU LOSE!");
      Future.delayed(const Duration(seconds: 4)).then((value) {
        stoppedAnimation = false;
        stoppedAnimationApp = false;
        index = 0;
        youWin = false;
        youLose = false;
        interstitialAd != null ? interstitialAd?.show() : null;
      });
    } else if (selectedWidgetUser == widgets[0] && selectedWidgetApp == widgets[2] ||
        selectedWidgetUser == widgets[1] && selectedWidgetApp == widgets[0] ||
        selectedWidgetUser == widgets[2] && selectedWidgetApp == widgets[1]) {
      youWin = true;
      BlocProvider.of<ScoreBloc>(context).increment();
      AlertManager.instance.showSnack(SnackType.success, message: "YOU WIN!");
      Future.delayed(const Duration(seconds: 3)).then((value) {
        stoppedAnimation = false;
        stoppedAnimationApp = false;
        index = 0;
        youWin = false;
        youLose = false;
      });
    }
  }

  @override
  void dispose() {
    interstitialAd?.dispose();
    super.dispose();
  }
}
