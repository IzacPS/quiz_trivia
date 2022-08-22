import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:quiz_app/cubit/select_question/selectquestion_cubit.dart';
import 'package:quiz_app/quiz_repository/quiz_repository.dart';
import 'package:quiz_app/widget/gameplay/gameplay.dart';
import 'package:quiz_app/widget/home/main_menu.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  MobileAds.instance.initialize();
  AdHelper.init();
  runApp(MyApp(
    quizRepository: QuizRepository(),
  ));
}

class MyApp extends StatelessWidget {
  final QuizRepository _quizRepository;

  const MyApp({Key? key, required QuizRepository quizRepository})
      : _quizRepository = quizRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(
            value: _quizRepository,
          )
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<CountdownCubit>(
              create: (_) => CountdownCubit(5),
            ),
            BlocProvider<MainBloc>(
              create: (_) => MainBloc(),
            ),
            BlocProvider<RequestQuestionsCubit>(
              create: (_) => RequestQuestionsCubit(_quizRepository),
            ),
            BlocProvider<GameplayTimelineCubit>(
              create: (_) => GameplayTimelineCubit(),
            ),
            BlocProvider<CountdownQuestionTimerBloc>(
              create: (_) => CountdownQuestionTimerBloc(20),
            ),
            BlocProvider<SelectquestionCubit>(
              create: (_) => SelectquestionCubit(),
            ),
            BlocProvider<DifficultyCubit>(
              create: (_) => DifficultyCubit(),
            ),
            BlocProvider<CategoryCubit>(
              create: (_) => CategoryCubit(),
            ),
            BlocProvider<NumberOfQuestionsCubit>(
              create: (_) => NumberOfQuestionsCubit(),
            ),
            BlocProvider<QuestionBloc>(
              create: (_) => QuestionBloc(),
            ),
          ],
          child: const MainView(),
        ),
      ),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: ((_, state) {
        Widget widget = const Scaffold();
        if (state is MainGameplay) {
          context.read<GameplayTimelineCubit>().restartGame();
          widget = const Gameplay();
        } else if (state is MainInitial) {
          widget = const MainMenu();
        }
        return widget;
      }),
    );
  }
}
