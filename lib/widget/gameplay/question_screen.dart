import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/bloc/countdown_question_timer/countdown_question_timer_bloc.dart';
import 'package:quiz_app/bloc/main/main_bloc.dart';
import 'package:quiz_app/bloc/question/question_bloc.dart';
import 'package:quiz_app/cubit/gameplay_timeline/gameplay_timeline_cubit.dart';
import 'package:quiz_app/cubit/select_question/selectquestion_cubit.dart';
import 'package:quiz_app/quiz_repository/models/question.dart';

// ignore: must_be_immutable
class QuestionScreen extends StatelessWidget {
  final List<Question> _q;
  int score = 0;
  bool isTheCorrectAnswers = false;

  QuestionScreen({Key? key, required List<Question> q})
      : _q = q,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    score = 0;
    return BlocBuilder<QuestionBloc, QuestionState>(
      //buildWhen: (lastState, currentState) => lastState != currentState,
      builder: (context, state) {
        if (state is QuestionInitial) {
          context.read<SelectquestionCubit>().disableSelectedQuestions();
          context
              .read<CountdownQuestionTimerBloc>()
              .add(CountdownQuestionTimerStartEvent());
        } else if (state is QuestionNext) {
          if (isTheCorrectAnswers) score++;
          context
              .read<QuestionBloc>()
              .add(QuestionStartEvent(state.questionIndex));
        } else if (state is QuestionEnd) {
          if (isTheCorrectAnswers) score++;
          context.read<GameplayTimelineCubit>().gotoGameFinished(score, _q);
        }
        return Scaffold(
          body: SafeArea(
            child: QuestionView(
              question: _q[state.questionIndex],
              index: state.questionIndex,
              isCorrectAnswer: (s) {
                isTheCorrectAnswers = s;
              },
            ),
          ),
        );
      },
    );
  }
}

class QuestionView extends StatelessWidget {
  final Question _question;
  final int index;
  final void Function(bool) isCorrectAnswer;
  const QuestionView(
      {Key? key,
      required Question question,
      required this.index,
      required this.isCorrectAnswer})
      : _question = question,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                BlocBuilder<CountdownQuestionTimerBloc,
                    CountdownQuestionTimerState>(builder: (_, state) {
                  if (state is CountdownQuestionTimerStop) {
                    context
                        .read<CountdownQuestionTimerBloc>()
                        .add(CountdownQuestionTimerRestartEvent());
                    context.read<QuestionBloc>().add(QuestionNextEvent());
                  }
                  return SizedBox(
                    height: 10,
                    child: LinearProgressIndicator(
                      value: state.step,
                    ),
                  );
                }),
                const SizedBox(
                  height: 8,
                ),
                ListTile(
                  title: Text(
                    '${index + 1} - ${_question.description}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                BlocBuilder<SelectquestionCubit, SelectquestionState>(
                    buildWhen: (previous, current) {
                  return previous.selectedPosition != current.selectedPosition;
                }, builder: (_, ss) {
                  isCorrectAnswer(
                      ss.selectedPosition == _question.correctAnswer);
                  return ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (_, index) {
                        return Card(
                          margin: const EdgeInsets.only(left: 8, right: 8),
                          elevation: (index == ss.selectedPosition) ? 4 : 1,
                          color: (index == ss.selectedPosition)
                              ? Colors.green[50]
                              : null,
                          child: ListTile(
                            leading: (index == ss.selectedPosition)
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                : const Icon(null),
                            title: Text(_question.answers[index].description),
                            onTap: () {
                              context
                                  .read<SelectquestionCubit>()
                                  .setSelectedQuestion(index);
                            },
                          ),
                        );
                      },
                      separatorBuilder: (_, index) => const SizedBox(
                            height: 8,
                          ),
                      itemCount: _question.answers.length); //,
                  //);
                }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    heroTag: null,
                    child: const Icon(Icons.close),
                    onPressed: () {
                      context
                          .read<CountdownQuestionTimerBloc>()
                          .add(CountdownQuestionTimerCloseEvent());
                      context
                          .read<QuestionBloc>()
                          .add(QuestionReconfigureEvent());

                      BlocProvider.of<MainBloc>(context)
                          .add(FinishSoloGameplayEvent());
                    },
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    child: const Icon(Icons.navigate_next),
                    onPressed: () {
                      context
                          .read<CountdownQuestionTimerBloc>()
                          .add(CountdownQuestionTimerStopEvent());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
