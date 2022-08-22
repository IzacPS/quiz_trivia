part of 'question_bloc.dart';

abstract class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object> get props => [];
}

class QuestionStartEvent extends QuestionEvent {
  final int questionIndex;

  const QuestionStartEvent(this.questionIndex);

  @override
  List<Object> get props => [questionIndex];
}

class QuestionNextEvent extends QuestionEvent {}

class QuestionEndEvent extends QuestionEvent {}

class QuestionReconfigureEvent extends QuestionEvent {}
