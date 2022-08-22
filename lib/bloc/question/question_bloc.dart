import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  int lastIndex = 0;
  QuestionBloc() : super(const QuestionInitial(0)) {
    on<QuestionStartEvent>((event, emit) {
      if (state is! QuestionInitial) {
        emit(QuestionInitial(event.questionIndex));
      }
    });
    on<QuestionNextEvent>((event, emit) {
      if (state.questionIndex == lastIndex) {
        add(QuestionEndEvent());
      } else {
        emit(QuestionNext(state.questionIndex + 1));
      }
    });
    on<QuestionEndEvent>((event, emit) {
      emit(QuestionEnd(lastIndex));
    });

    on<QuestionReconfigureEvent>((event, emit) {
      emit(const QuestionReconfigure());
    });
  }

  set numberOfQuestions(int number) {
    lastIndex = number - 1;
  }
}
