import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/globals/solo_play_config_info.dart';
import 'package:quiz_app/quiz_repository/quiz_repository.dart'
    show QuizRepository;

part 'request_questions_state.dart';

class RequestQuestionsCubit extends Cubit<RequestQuestionsState> {
  final QuizRepository quizRepository;

  RequestQuestionsCubit(this.quizRepository)
      : super(const RequestQuestionsState());

  void start() {
    if (state.status != RequestQuestionsStatus.initial) {
      emit(const RequestQuestionsState());
    }
  }

  void startFromCountdown() {
    if (state.status != RequestQuestionsStatus.initial) {
      emit(const RequestQuestionsState(
          status: RequestQuestionsStatus.startgame));
    }
  }

  Future<void> getQuestions(
      String category, String difficulty, int limit) async {
    if (!categoryMap.containsValue(category) ||
        !difficultyMap.containsValue(difficulty) ||
        !numberOfQuestionsList.contains(limit)) {
      return;
    }

    emit(const RequestQuestionsState(status: RequestQuestionsStatus.loading));

    try {
      await quizRepository.getQuestions(category, difficulty, limit);
      emit(const RequestQuestionsState(status: RequestQuestionsStatus.success));
      Future.delayed(const Duration(milliseconds: 500), () {
        emit(const RequestQuestionsState(
            status: RequestQuestionsStatus.startgame));
      });
    } on Exception {
      emit(const RequestQuestionsState(status: RequestQuestionsStatus.failure));
    }
  }
}
