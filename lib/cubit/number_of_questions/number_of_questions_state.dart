part of 'number_of_questions_cubit.dart';

abstract class NumberOfQuestionsState {
  late int number;
  NumberOfQuestionsState(this.number);
}

class NumberOfQuestionsInitial extends NumberOfQuestionsState {
  NumberOfQuestionsInitial() : super(5);
}

class NumberOfQuestionsCurrent extends NumberOfQuestionsState {
  NumberOfQuestionsCurrent(int number) : super(number);
}
