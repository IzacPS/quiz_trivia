import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quiz_app/ad/ad_helper.dart';
import 'package:quiz_app/bloc/countdown_question_timer/countdown_question_timer_bloc.dart';
import 'package:quiz_app/bloc/main/main_bloc.dart';
import 'package:quiz_app/bloc/question/question_bloc.dart';
import 'package:quiz_app/cubit/category/category_cubit.dart';
import 'package:quiz_app/cubit/countdown/countdown_cubit.dart';
import 'package:quiz_app/cubit/difficulty/difficulty_cubit.dart';
import 'package:quiz_app/cubit/gameplay_timeline/gameplay_timeline_cubit.dart';
import 'package:quiz_app/cubit/number_of_questions/number_of_questions_cubit.dart';
import 'package:quiz_app/cubit/request_questions/request_questions_cubit.dart';
import 'package:quiz_app/quiz_repository/models/question.dart';
import 'package:quiz_app/widget/gameplay/answers_screen.dart';
import 'package:quiz_app/widget/solo_game/solo_game_page.dart';

// ignore: must_be_immutable
class FinishScreen extends StatelessWidget {
  int score;
  List<Question> questions;
  FinishScreen({Key? key, required this.score, required this.questions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Your score is:',
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                '$score/${questions.length}',
                style: const TextStyle(color: Colors.purple, fontSize: 48),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton.extended(
                  heroTag: null,
                  icon: const Icon(Icons.question_answer),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return AnswersScreen(
                        questions: questions,
                      );
                    }));
                  },
                  label: const Text('See Answers')),
              const SizedBox(
                height: 20,
              ),
              FloatingActionButton.extended(
                  heroTag: null,
                  icon: const Icon(Icons.restart_alt),
                  onPressed: () {
                    context.read<RequestQuestionsCubit>().startFromCountdown();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => MultiBlocProvider(providers: [
                                BlocProvider<RequestQuestionsCubit>.value(
                                  value: context.read<RequestQuestionsCubit>(),
                                ),
                                BlocProvider<CountdownCubit>.value(
                                  value: context.read<CountdownCubit>(),
                                ),
                                BlocProvider<MainBloc>.value(
                                  value: context.read<MainBloc>(),
                                ),
                                BlocProvider<GameplayTimelineCubit>.value(
                                  value: context.read<GameplayTimelineCubit>(),
                                ),
                                BlocProvider<DifficultyCubit>.value(
                                  value: context.read<DifficultyCubit>(),
                                ),
                                BlocProvider<CategoryCubit>.value(
                                  value: context.read<CategoryCubit>(),
                                ),
                                BlocProvider<NumberOfQuestionsCubit>.value(
                                  value: context.read<NumberOfQuestionsCubit>(),
                                ),
                                BlocProvider<CountdownQuestionTimerBloc>.value(
                                  value: context
                                      .read<CountdownQuestionTimerBloc>(),
                                ),
                                BlocProvider<QuestionBloc>(
                                  create: (_) => QuestionBloc(),
                                ),
                              ], child: SoloGamePage())),
                    );
                  },
                  label: const Text('Restart')),
              const SizedBox(
                height: 20,
              ),
              FloatingActionButton.extended(
                  heroTag: null,
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    BlocProvider.of<MainBloc>(context)
                        .add(FinishSoloGameplayEvent());
                  },
                  label: const Text('Quit')),
            ],
          ),
          if (AdHelper.bannerAd != null && AdHelper.bannerAd!.isReady)
            SizedBox(
              width: AdSize.banner.width.toDouble(),
              height: AdSize.banner.height.toDouble(),
              child: AdWidget(ad: AdHelper.bannerAd!.bannerAd!),
            )
          else
            const SizedBox.shrink()
        ],
      ),
    );
  }
}
