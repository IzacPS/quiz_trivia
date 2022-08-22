import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/ad/ad_helper.dart';
import 'package:quiz_app/cubit/category/category_cubit.dart';
import 'package:quiz_app/cubit/countdown/countdown_cubit.dart';
import 'package:quiz_app/cubit/difficulty/difficulty_cubit.dart';
import 'package:quiz_app/cubit/number_of_questions/number_of_questions_cubit.dart';
import 'package:quiz_app/cubit/request_questions/request_questions_cubit.dart';
import 'package:quiz_app/widget/solo_game/config_screen.dart';
import 'package:quiz_app/widget/solo_game/countdown_page.dart';
import 'package:quiz_app/widget/solo_game/game_ready.dart';
import 'package:quiz_app/widget/solo_game/loading_screen.dart';

class SoloGamePage extends StatelessWidget {
  //final QuizRepository _quizRepository;

  SoloGamePage({Key? key})
      : //_quizRepository = quizRepository,
        super(key: key) {
    AdHelper.startBannerAd();
    AdHelper.startInterstitialAd();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return const SoloGameView();
  }
}

class SoloGameView extends StatelessWidget {
  const SoloGameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<RequestQuestionsCubit, RequestQuestionsState>(
          builder: ((_, state) {
            switch (state.status) {
              case RequestQuestionsStatus.initial:
                context.read<NumberOfQuestionsCubit>().start();
                context.read<DifficultyCubit>().start();
                context.read<CategoryCubit>().start();
                return ConfigScreen();
              case RequestQuestionsStatus.loading:
                return const LoadingScreen();
              case RequestQuestionsStatus.success:
                return const GameReadyScreen();
              case RequestQuestionsStatus.startgame:
                context.read<CountdownCubit>().start();
                return const CountDownPage();

              case RequestQuestionsStatus.failure:
              default:
                return Scaffold(
                  body: SafeArea(
                    child: Container(color: Colors.red),
                  ),
                );
            }
          }),
        ),
      ),
    );
  }
}
