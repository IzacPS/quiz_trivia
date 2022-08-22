import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'countdown_state.dart';

class CountdownCubit extends Cubit<CountdownState> {
  Timer? timer;
  final int _duration;
  CountdownCubit(int duration)
      : _duration = duration,
        super(CountdownInitial(duration));

  void start() {
    if (state is! CountdownInitial) {
      emit(CountdownInitial(_duration));
    }
  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      countDown();
    });
  }

  void countDown() => emit(CountdownInProgress(state.duration - 1));
  void finishCounter() {
    timer?.cancel();
    emit(const CountdownFinish());
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}
