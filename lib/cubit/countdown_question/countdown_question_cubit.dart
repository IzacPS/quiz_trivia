// import 'dart:async';

// import 'package:equatable/equatable.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// part 'countdown_question_state.dart';

// class CountdownQuestionCubit extends Cubit<CountdownQuestionState> {
//   Timer? timer;
//   late int _duration;
//   late double stepAmount;
//   final int stepTime = 50;
//   CountdownQuestionCubit(double duration)
//       : super(const CountdownQuestionInitial()) {
//     _duration = (duration.toDouble() * (1000.0 / stepTime)).toInt();
//     stepAmount = 1.0 / (duration.toDouble() * (1000.0 / stepTime));
//   }

//   void start() {
//     if (state is! CountdownQuestionInitial) {
//       emit(const CountdownQuestionInitial());
//     }
//   }

//   void startCountdown() {
//     emit(CountdownQuestionStart(_duration, 1.0));
//     timer = Timer.periodic(Duration(milliseconds: stepTime), (timer) {
//       countDown();
//     });
//   }

//   void skipToNext() {
//     emit(const CountdownQuestionSkipToNext());
//   }

//   void countDown() => emit(
//       CountdownQuestionInProgress(state.duration - 1, state.step - stepAmount));

//   void restartCounter() {
//     timer?.cancel();
//     emit(const CountdownQuestionFinish());
//   }

//   void finishCounter() {
//     timer?.cancel();
//   }

//   @override
//   Future<void> close() {
//     timer?.cancel();
//     return super.close();
//   }
// }
