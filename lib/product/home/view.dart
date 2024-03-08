import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r_p_s_game/core/base/modules/navigation/navigation_service.dart';
import 'package:r_p_s_game/core/base/view.dart';
import 'package:r_p_s_game/core/bloc/block_manager.dart';
import 'package:r_p_s_game/core/components/button.dart';
import 'package:r_p_s_game/product/home/viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends HomeViewmodel {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScoreBloc>(
      create: (BuildContext context) => ScoreBloc(ScoreState.instance),
      child: BaseView(
        scaffoldBackgroundColor: colors.lightBlue,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: deviceWidth / 5, top: 30),
                child: SizedBox(
                  height: deviceHeight / 3.5,
                  child: Stack(
                    children: buildWidgets(),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "to play the game...",
                style: TextStyle(color: colors.white, fontStyle: FontStyle.italic, fontSize: 20),
              ),
              CustomButton(
                onPressed: () {
                  NavigationService.instance.navigateToPage(path: NavigationPaths.game);
                },
                text: "PRESS!!!",
              ),
              const SizedBox(
                height: 30,
              ),
              Scores(),
            ],
          ),
        ),
      ),
    );
  }
}
