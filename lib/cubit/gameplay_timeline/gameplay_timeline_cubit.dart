import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/quiz_repository/models/question.dart';

part 'gameplay_timeline_state.dart';

class GameplayTimelineCubit extends Cubit<GameplayTimelineState> {
  int numberOfQuestions = 0;

  GameplayTimelineCubit() : super(GameplayTimelineInitial());

  void restartGame() {
    if (state is! GameplayTimelineInitial) {
      numberOfQuestions = 0;
      emit(GameplayTimelineRestart());
    }
  }

  void gotoGameFinished(int score, List<Question> questions) {
    emit(GameplayTimelineGameFinished(score: score, questions: questions));
  }
}
