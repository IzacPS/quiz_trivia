part of 'countdown_question_timer_bloc.dart';

abstract class CountdownQuestionTimerEvent extends Equatable {
  const CountdownQuestionTimerEvent();

  @override
  List<Object> get props => [];
}

class CountdownQuestionTimerRestartEvent extends CountdownQuestionTimerEvent {}

class CountdownQuestionTimerStartEvent extends CountdownQuestionTimerEvent {}

class CountdownQuestionTimerInProgressEvent
    extends CountdownQuestionTimerEvent {}

class CountdownQuestionTimerStopEvent extends CountdownQuestionTimerEvent {}

class CountdownQuestionTimerCloseEvent extends CountdownQuestionTimerEvent {}
