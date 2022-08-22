import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/ad/ad_helper.dart';
import 'package:quiz_app/bloc/question/question_bloc.dart';
import 'package:quiz_app/cubit/gameplay_timeline/gameplay_timeline_cubit.dart';
import 'package:quiz_app/quiz_repository/quiz_repository.dart';
import 'package:quiz_app/widget/gameplay/finished_screen.dart';
import 'package:quiz_app/widget/gameplay/question_screen.dart';

class Gameplay extends StatelessWidget {
  const Gameplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<GameplayTimelineCubit, GameplayTimelineState>(
          builder: (_, state) {
            context.read<QuestionBloc>().add(const QuestionStartEvent(0));

            if (state is GameplayTimelineGameFinished) {
              AdHelper.interstitialAd?.show();
              return FinishScreen(
                  score: state.score, questions: state.questions);
            } else if (state
                is GameplayTimelineRestart) {} // else if (state is GameplayTimelineRestart) {}
            context.read<QuestionBloc>().numberOfQuestions =
                context.read<QuizRepository>().questions.length;
            return QuestionScreen(q: context.read<QuizRepository>().questions);
          },
        ),
      ),
      //body: QuestionScreen(),
    );
  }
}
