import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'countdown_question_timer_event.dart';
part 'countdown_question_timer_state.dart';

class CountdownQuestionTimerBloc
    extends Bloc<CountdownQuestionTimerEvent, CountdownQuestionTimerState> {
  Timer? timer;
  late int _duration;
  late double stepAmount;
  final int stepTime = 50;

  CountdownQuestionTimerBloc(double duration)
      : super(const CountdownQuestionTimerInitial()) {
    _duration = (duration.toDouble() * (1000.0 / stepTime)).toInt();
    stepAmount = 1.0 / (duration.toDouble() * (1000.0 / stepTime));

    on<CountdownQuestionTimerRestartEvent>((event, emit) {
      emit(const CountdownQuestionTimerInitial());
    });

    on<CountdownQuestionTimerStartEvent>((event, emit) {
      emit(CountdownQuestionTimerStart(_duration, 1.0));
      timer = Timer.periodic(Duration(milliseconds: stepTime), (timer) {
        add(CountdownQuestionTimerInProgressEvent());
      });
    });
    on<CountdownQuestionTimerInProgressEvent>((event, emit) {
      if (state.duration == 0) {
        add(CountdownQuestionTimerStopEvent());
        emit(const CountdownQuestionTimerInitial());
      } else {
        emit(CountdownQuestionTimerInProgress(
            state.duration - 1, state.step - stepAmount));
      }
    });
    on<CountdownQuestionTimerStopEvent>((event, emit) {
      timer?.cancel();
      emit(const CountdownQuestionTimerStop());
    });

    on<CountdownQuestionTimerCloseEvent>((event, emit) {
      timer?.cancel();
      emit(const CountdownQuestionTimerInitial());
    });
  }
}
