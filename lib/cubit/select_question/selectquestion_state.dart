part of 'selectquestion_cubit.dart';

abstract class SelectquestionState extends Equatable {
  final int selectedPosition;
  const SelectquestionState(this.selectedPosition);

  @override
  List<Object> get props => [selectedPosition];
}

class SelectquestionInitial extends SelectquestionState {
  const SelectquestionInitial() : super(-1);
}

class SelectquestionCurrent extends SelectquestionState {
  const SelectquestionCurrent(int selectedPosition) : super(selectedPosition);
}
