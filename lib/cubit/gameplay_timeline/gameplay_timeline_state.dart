part of 'gameplay_timeline_cubit.dart';

abstract class GameplayTimelineState extends Equatable {
  const GameplayTimelineState();

  @override
  List<Object> get props => [];
}

class GameplayTimelineInitial extends GameplayTimelineState {}

class GameplayTimelineRestart extends GameplayTimelineState {}

class GameplayTimelineGameFinished extends GameplayTimelineState {
  final int score;
  final List<Question> questions;
  const GameplayTimelineGameFinished(
      {required this.score, required this.questions});

  @override
  List<Object> get props => [score, questions];
}
