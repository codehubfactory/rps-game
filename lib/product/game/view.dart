import 'package:flutter/material.dart';
import 'package:r_p_s_game/core/base/view.dart';
import 'package:r_p_s_game/core/components/appbar.dart';
import 'package:r_p_s_game/core/components/button.dart';
import 'package:r_p_s_game/core/components/svg_widget.dart';
import 'package:r_p_s_game/product/game/viewmodel.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends GameViewmodel {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      scaffoldBackgroundColor: colors.lightBlue,
      body: Stack(
        children: [
          const CustomAppBar(isBackButton: true),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Center(
                    child: stoppedAnimation
                        ? AnimatedSwitcher(
                            duration: const Duration(microseconds: 500),
                            key: Key(indexApp.toString()),
                            child: stoppedAnimationApp ? selectedWidgetApp : widgets[indexApp],
                          )
                        : iconWidget(Icons.back_hand_outlined, 50),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Text(
                        "vs",
                        style: TextStyle(color: colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(seconds: 1),
                    key: Key(index.toString()),
                    child: stoppedAnimation ? selectedWidgetUser : widgets[index],
                  ),
                ],
              ),
              Visibility(
                visible: !stoppedAnimation,
                child: CustomButton(
                  onPressed: () {
                    stopAnimation();
                  },
                  text: "STOP",
                ),
              ),
            ],
          ),
          stoppedAnimationApp
              ? Positioned.fill(
                  child: AnimatedOpacity(
                    opacity: 0.8,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      color: colors.darkBlue,
                    ),
                  ),
                )
              : const SizedBox(),
          Align(
            alignment: Alignment.center,
            child: youWin
                ? selectedWidgetUser
                : youLose
                    ? selectedWidgetApp
                    : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
