part of 'question_bloc.dart';

abstract class QuestionState extends Equatable {
  final int questionIndex;
  const QuestionState(this.questionIndex);

  @override
  List<Object> get props => [questionIndex];
}

class QuestionInitial extends QuestionState {
  const QuestionInitial(int index) : super(index);
}

class QuestionReconfigure extends QuestionState {
  const QuestionReconfigure() : super(0);
}

class QuestionNext extends QuestionState {
  const QuestionNext(int next) : super(next);
}

class QuestionEnd extends QuestionState {
  const QuestionEnd(int next) : super(next);
}
