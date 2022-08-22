part of 'difficulty_cubit.dart';

abstract class DifficultyState extends Equatable {
  final String? name;
  const DifficultyState(this.name);

  @override
  List<Object?> get props => [name];
}

class DifficultyInitial extends DifficultyState {
  const DifficultyInitial() : super('Easy');
}

class DifficultyCurrent extends DifficultyState {
  const DifficultyCurrent(String? name) : super(name);
}
