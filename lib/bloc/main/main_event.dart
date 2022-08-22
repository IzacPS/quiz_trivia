part of 'main_bloc.dart';

abstract class MainEvent {
  const MainEvent();
}

class StartSoloGameplayEvent extends MainEvent {}

class FinishSoloGameplayEvent extends MainEvent {}

//class PopMainMenuEvent extends MainEvent {}
