import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'selectquestion_state.dart';

class SelectquestionCubit extends Cubit<SelectquestionState> {
  SelectquestionCubit() : super(const SelectquestionInitial());

  void disableSelectedQuestions() {
    emit(const SelectquestionInitial());
  }

  void setSelectedQuestion(int selectedQuestion) {
    emit(SelectquestionCurrent(selectedQuestion));
  }
}
