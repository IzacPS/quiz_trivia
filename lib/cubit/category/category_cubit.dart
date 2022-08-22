import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  void start() {
    if (state is! CategoryInitial) {
      emit(CategoryInitial());
    }
  }

  void changeCategory(String? name) => emit(CategoryCurrent(name));
}
