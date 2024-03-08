import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r_p_s_game/core/base/view.dart';

import '../../core/base/state.dart';
import '../../core/bloc/block_manager.dart';

class ScoreView extends StatefulWidget {
  const ScoreView({super.key});

  @override
  State<ScoreView> createState() => _ScoreViewState();
}

class _ScoreViewState extends BaseState<ScoreView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScoreBloc>(
      create: (BuildContext context) => ScoreBloc(ScoreState.instance),
      child: AppRoot(),
    );
  }
}

class AppRoot extends BaseStateless {
  AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      scaffoldBackgroundColor: colors.lightBlue,
      body: BlocBuilder<ScoreBloc, ScoreState>(
          bloc: BlocProvider.of<ScoreBloc>(context),
          builder: (context, ScoreState state) {
            return Center(
              child: ListTile(
                title: Text("Your Score : ${state.score_count}"),
              ),
            );
          }),
    );
  }
}

class _CounterAndButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(4.0).copyWith(top: 32.0, bottom: 32.0),
      color: Colors.white70,
      child: Column(
        children: <Widget>[
          const Text('(child widget)'),
          BlocBuilder<ScoreBloc, ScoreState>(
            bloc: BlocProvider.of<ScoreBloc>(context),
            builder: (context, ScoreState state) {
              return Text(
                '${state.score_count}',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            },
          ),
          ButtonBar(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.add),
                // ###6. Post new event by calling functions in bloc or by
                // bloc.add(newEvent);
                onPressed: () =>
                    BlocProvider.of<ScoreBloc>(context).increment(),
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () =>
                    BlocProvider.of<ScoreBloc>(context).decrement(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
