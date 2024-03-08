import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r_p_s_game/core/bloc/block_manager.dart';
import 'package:r_p_s_game/product/home/view.dart';

import '../../core/base/modules/extension/asset_extension.dart';
import '../../core/base/state.dart';
import '../../core/components/score_card.dart';
import '../../core/components/svg_widget.dart';

abstract class HomeViewmodel extends BaseState<HomeView> with TickerProviderStateMixin {
  late AnimationController animationcontroller;
  @override
  void initState() {
    animationcontroller = AnimationController(duration: const Duration(seconds: 17), vsync: this, upperBound: 2)..repeat();
    super.initState();
  }

  List<Widget> buildWidgets() {
    return [
      _buildWidget(WidgetType.Rock, leftPadding: 0, topPadding: deviceHeight / 10),
      _buildWidget(WidgetType.Paper, leftPadding: deviceWidth / 5, topPadding: deviceHeight / 40),
      _buildWidget(WidgetType.Cut, leftPadding: deviceWidth / 3, topPadding: deviceHeight / 10),
    ];
  }

  Widget _buildWidget(WidgetType type, {required double leftPadding, required double topPadding}) {
    return Positioned(
      left: leftPadding,
      top: topPadding,
      child: AnimatedBuilder(
        animation: animationcontroller,
        builder: (context, child) {
          return Transform.rotate(
            angle: animationcontroller.value * 1.5 * pi,
            child: child,
          );
        },
        child: _buildWidgetContent(type),
      ),
    );
  }

  Widget _buildWidgetContent(WidgetType type) {
    switch (type) {
      case WidgetType.Rock:
        return svgWidget(GameAsset.rock, 100);
      case WidgetType.Paper:
        return iconWidget(Icons.menu_book, 100);
      case WidgetType.Cut:
        return iconWidget(Icons.cut, 100);
    }
  }

  @override
  void dispose() {
    animationcontroller.dispose();
    super.dispose();
  }
}

enum WidgetType { Rock, Paper, Cut }

class Scores extends BaseStateless {
  Scores({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreBloc, ScoreState>(
        bloc: BlocProvider.of<ScoreBloc>(context),
        builder: (context, ScoreState state) {
          return FutureBuilder(
            future: Future.wait([state.score_count_get, state.score_list_get]),
            builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData || snapshot.hasError) {
                return const Center(child: CircularProgressIndicator());
              }
              final int scoreCount = snapshot.data![0];
              final List<String> scoreList = snapshot.data![1] as List<String>;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "See all your scores :    $scoreCount",
                          style: TextStyle(color: colors.darkBlue, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<ScoreBloc>(context).clearScores();
                            },
                            icon: Icon(
                              Icons.delete_outline_outlined,
                              size: 30,
                              color: colors.darkBlue,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: deviceHeight(context) / 2,
                      child: ListView.builder(
                          itemCount: scoreList.length,
                          itemBuilder: (context, index) {
                            return scoreCard(scoreList[index], colors.whiteLayer);
                          }),
                    )
                  ],
                ),
              );
            },
          );
        });
  }
}
