part of 'countdown_cubit.dart';

abstract class CountdownState extends Equatable {
  final int duration;
  const CountdownState(this.duration);

  @override
  List<Object> get props => [duration];
}

class CountdownInitial extends CountdownState {
  const CountdownInitial(int duration) : super(duration);
}

class CountdownInProgress extends CountdownState {
  const CountdownInProgress(int duration) : super(duration);
}

class CountdownFinish extends CountdownState {
  const CountdownFinish() : super(0);
}
