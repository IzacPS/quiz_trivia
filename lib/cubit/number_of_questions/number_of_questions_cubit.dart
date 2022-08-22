import 'package:flutter_bloc/flutter_bloc.dart';

part 'number_of_questions_state.dart';

class NumberOfQuestionsCubit extends Cubit<NumberOfQuestionsState> {
  NumberOfQuestionsCubit() : super(NumberOfQuestionsInitial());

  void start() {
    if (state is! NumberOfQuestionsInitial) {
      emit(NumberOfQuestionsInitial());
    }
  }

  void changeNumberOfQuestions(int number) =>
      emit(NumberOfQuestionsCurrent(number));
}
