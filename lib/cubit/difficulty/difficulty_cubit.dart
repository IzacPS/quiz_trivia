import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'difficulty_state.dart';

class DifficultyCubit extends Cubit<DifficultyState> {
  DifficultyCubit() : super(const DifficultyInitial());

  void start() {
    if (state is! DifficultyInitial) {
      emit(const DifficultyInitial());
    }
  }

  void changeDifficulty(String? name) => emit(DifficultyCurrent(name));
}
