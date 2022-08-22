import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial()) {
    // on<MainEvent>(
    //   (event, emit) async {
    //     if (event is StartSoloGameplayEvent) {
    //       emit(MainGameplay());
    //     } else if (event is FinishSoloGameplayEvent) {
    //       emit(MainInitial());
    //     }
    //   },
    // );
    on<StartSoloGameplayEvent>((event, emit) {
      emit(MainGameplay());
    });
    on<FinishSoloGameplayEvent>((event, emit) {
      emit(MainInitial());
    });
  }
}
