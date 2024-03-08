// ###1. Define an Event classes that represent an event in our app. The widgets
// pass _MyEvent objects as inputs to ScoreBloc.
import 'package:bloc/bloc.dart';
import 'package:r_p_s_game/core/cached/cached_manager.dart';

class _MyEvent {
  final DateTime timestamp;

  _MyEvent({DateTime? timestamp}) : this.timestamp = timestamp ?? DateTime.now();
}

class _IncrementEvt extends _MyEvent {
  _IncrementEvt() {
    print(this.timestamp);
  }
}

class _DecrementEvt extends _MyEvent {}

class _ClearEvt extends _MyEvent {}

// ###2. Define a State class that represents our app's state. ScoreBloc's output
// would be such a state. Note the state must be IMMUTABLE in flutter_bloc from
// v0.6.0. Instead of mutating the state, create a new state instance.

class ScoreState {
  static ScoreState? _instance;
  static ScoreState get instance {
    _instance ??= ScoreState._init();
    return _instance!;
  }

  ScoreState._init() {
    CachedManager().getScore().then((value) {
      this.score_count = value;
    });
    CachedManager().getScoreList().then((value) => this.scoreList = value ?? []);
  }

  int score_count = 0;
  List<String> scoreList = [];

  update_score_count(int score_count) {
    CachedManager().score_record(score_count);
    return this;
  }

  update_score_list(List<String> list) {
    CachedManager().score_recordList(list);
    return this;
  }

  Future<int> get score_count_get async {
    score_count = await CachedManager().getScore();
    return score_count;
  }

  Future<List<String>> get score_list_get async {
    scoreList = await CachedManager().getScoreList() ?? [];
    return scoreList;
  }
}

// ###3. Define a ScoreBloc class which extends Bloc<_MyEvent, _ScoreState> from the
// flutter_bloc package. With this package, we don't need to manage the stream
// controllers.
class ScoreBloc extends Bloc<_MyEvent, ScoreState> {
  ScoreBloc(super.initialState) {
    on<_IncrementEvt>((_, emit) {
      emit(ScoreState.instance.update_score_count(state.score_count + 1));
      List<String> list = state.scoreList;
      list.add("win");
      emit(ScoreState.instance.update_score_list(list));
    });
    on<_DecrementEvt>((_, emit) {
      emit(ScoreState.instance.update_score_count(state.score_count - 1));
      List<String> list = state.scoreList;
      list.add("lose");
      emit(ScoreState.instance.update_score_list(list));
    });
    on<_ClearEvt>((_, emit) {
      emit(ScoreState.instance.update_score_count(0));
      emit(ScoreState.instance.update_score_list([]));
    });
  }

  // Instead of doing bloc.sink.add(), we do bloc.add().
  void increment() => this.add(_IncrementEvt());
  void decrement() => this.add(_DecrementEvt());
  void clearScores() => this.add(_ClearEvt());
}
