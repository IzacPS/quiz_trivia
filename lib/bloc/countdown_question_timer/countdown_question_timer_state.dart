part of 'countdown_question_timer_bloc.dart';

abstract class CountdownQuestionTimerState extends Equatable {
  final int duration;
  final double step;
  const CountdownQuestionTimerState(this.duration, this.step);

  @override
  List<Object> get props => [duration, step];
}

class CountdownQuestionTimerInitial extends CountdownQuestionTimerState {
  const CountdownQuestionTimerInitial() : super(0, 1);
}

class CountdownQuestionTimerStart extends CountdownQuestionTimerState {
  const CountdownQuestionTimerStart(int duration, double step)
      : super(duration, step);
}

class CountdownQuestionTimerInProgress extends CountdownQuestionTimerState {
  const CountdownQuestionTimerInProgress(int duration, double step)
      : super(duration, step);
}

class CountdownQuestionTimerStop extends CountdownQuestionTimerState {
  const CountdownQuestionTimerStop() : super(0, 0);
}
